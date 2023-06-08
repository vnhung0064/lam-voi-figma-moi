
//  SongInPlayListViewController.swift
//  test1
//
//  Created by Hung Vu on 30/05/2023.
//

import UIKit

class SongInPlayListViewController: UIViewController {
    
    var songs: [Song] = []

    var playlists: [Playlist] = []

    
    @IBOutlet weak var TablePlaylist: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TablePlaylist.register(SongTableViewCell.nib(), forCellReuseIdentifier:SongTableViewCell.identifier)
        TablePlaylist.dataSource = self
        TablePlaylist.delegate = self
        fetchdatafromUserdefault()
        TablePlaylist.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)



    }
    static func makeSelf() -> SongInPlayListViewController {
                let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let rootViewController: SongInPlayListViewController = storyboard.instantiateViewController(withIdentifier: "SongInPlayListViewController") as! SongInPlayListViewController
                                        return rootViewController
            }
    func fetchdatafromUserdefault() {
        if let encodedData = UserDefaults.standard.data(forKey: key_playlists_userdefault) {
            do {
                let decodedPlaylists = try JSONDecoder().decode([Playlist].self, from: encodedData)
                playlists = decodedPlaylists
                TablePlaylist.reloadData()
                print("Playlists loaded from UserDefaults")
                
                // Kiểm tra xem có playlist nào được chọn không
                if let selectedPlaylist = playlists.first {
                    songs = selectedPlaylist.songs
                    TablePlaylist.reloadData()
                }
            } catch {
                print("Failed to load playlists from UserDefaults: \(error)")
            }
        } else {
            print("No saved playlists found in UserDefaults")
        }
    }

   

    
}
extension SongInPlayListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
        
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier, for:indexPath) as! SongTableViewCell
        cell.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        let song = songs[indexPath.row]
        cell.configure(with: song)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
}
