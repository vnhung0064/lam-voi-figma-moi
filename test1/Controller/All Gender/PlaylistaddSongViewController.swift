//
//  PlaylistaddSongViewController.swift
//  test1
//
//  Created by Hung Vu on 02/06/2023.
//

import UIKit
import SDWebImage
class PlaylistaddSongViewController: UIViewController {
    
    @IBOutlet weak var PlayListTableView: UITableView!
    static let shared = PlaylistaddSongViewController()
    
    var playlists: [Playlist] = []
    
    var playlist: Playlist?
    
    var currentsong: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlayListTableView.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        
        PlayListTableView.register(PlayListTableViewCell.nib(), forCellReuseIdentifier: PlayListTableViewCell.identifier)
        
        
    
        
        PlayListTableView.reloadData()
        
        PlayListTableView.delegate = self
        PlayListTableView.dataSource = self
        
        if let savedPlaylistsData = UserDefaults.standard.data(forKey: key_playlists_userdefault) {
            do {
                let playlists = try JSONDecoder().decode([Playlist].self, from: savedPlaylistsData)
                self.playlists = playlists
            } catch {
                print("Failed to load playlists from UserDefaults: \(error)")
            }
        }
        
    }
    static func makeSelf(currentsong: Song) -> PlaylistaddSongViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PlaylistaddSongViewController") as! PlaylistaddSongViewController
        viewController.currentsong = currentsong
        return viewController
    }
    
    func getPlaylists() -> [Playlist] {
        return playlists
    }
    func removePlaylist(atIndex index: Int) {
        playlists.remove(at: index)
    }
    func savePlaylists() {
        do {
            let encodedData = try JSONEncoder().encode(playlists)
            UserDefaults.standard.set(encodedData, forKey: key_playlists_userdefault)
        } catch {
            print("Failed to save playlists: \(error)")
        }
    }
    
    func loadPlaylists() {
        if let encodedData = UserDefaults.standard.data(forKey: key_playlists_userdefault) {
            do {
                let decodedPlaylists = try JSONDecoder().decode([Playlist].self, from: encodedData)
                playlists = decodedPlaylists
                print(playlists)
            } catch {
                print("Failed to load playlists: \(error)")
            }
        }
    }
}

extension PlaylistaddSongViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayListTableViewCell.identifier, for: indexPath)as? PlayListTableViewCell
        cell?.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        
        let playlist = playlists[indexPath.row]
        cell!.nameLabel.text = playlist.name
        cell!.songcount.text = "\(playlist.songs.count) songs"
        
        if let lastSong = playlist.songs.last {
            cell!.setLastSongAlbumImage(lastSong.album_image)
               }
        else {
            cell?.PlaylistImage.image = UIImage(named: "Add Icon 1")

        }
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    func checkDuplicateSongInPlaylist(song: Song, playlist: Playlist) -> Bool {
        if playlist.songs.contains(where: { $0.id == song.id }) {
            return true // Bài hát đã tồn tại trong danh sách phát
        } else {
            return false // Bài hát chưa tồn tại trong danh sách phát
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlaylist = playlists[indexPath.row]
           
           if checkDuplicateSongInPlaylist(song: currentsong!, playlist: selectedPlaylist) {
               // Bài hát đã tồn tại trong danh sách phát
               let alertController = UIAlertController(title: "Thông báo", message: "Bài hát đã tồn tại trong danh sách phát này.", preferredStyle: .alert)
               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               alertController.addAction(okAction)
               present(alertController, animated: true, completion: nil)
           } else {
               var playlist = selectedPlaylist
               playlist.songs.append(currentsong!)
               playlists[indexPath.row] = playlist
               tableView.reloadData()
               savePlaylistsToUserDefaults()
           }
            
    }
    func savePlaylistsToUserDefaults() {
        do {
            let playlistsData = try JSONEncoder().encode(playlists)
            UserDefaults.standard.set(playlistsData, forKey:key_playlists_userdefault )
        } catch {
            print("Failed to save playlists to UserDefaults: \(error)")
        }
    }

}

