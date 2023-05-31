
//  SongInPlayListViewController.swift
//  test1
//
//  Created by Hung Vu on 30/05/2023.
//

import UIKit

class SongInPlayListViewController: UIViewController {
    
    var song: [Song] = []

    var playlist: [Song] = []


    @IBOutlet weak var TablePlaylist: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TablePlaylist.register(TableViewCell.nib(), forCellReuseIdentifier:TableViewCell.identifier)

        TablePlaylist.dataSource = self
        TablePlaylist.delegate = self

        
    }
    static func makeSelf() -> SongInPlayListViewController {
                let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let rootViewController: SongInPlayListViewController = storyboard.instantiateViewController(withIdentifier: "SongInPlayListViewController") as! SongInPlayListViewController
                                        return rootViewController
            }
    func addToPlaylist(song: Song) {
        // Add the song to the playlist
        playlist.append(song)
        
        // Perform any additional actions or logic after adding to the playlist
        // For example, you could update the UI to reflect the added song
        
        // Reload the table view or update any relevant UI elements
        TablePlaylist.reloadData()
        
        // Show a success message or perform any other desired actions
        print("Song added to playlist: \(song.name)")
    }
    

}
extension SongInPlayListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return song.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for:indexPath) as! TableViewCell
        cell.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
}
