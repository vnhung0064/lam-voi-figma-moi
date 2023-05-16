//
//  PlaylistViewController.swift
//  test1
//
//  Created by Hung Vu on 28/04/2023.
//

import UIKit

class PlaylistViewController: UIViewController {
   
    var playlists: [Playlist] = []


    @IBOutlet weak var PlayListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor: UIColor.white,
                            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
                        ]
        
        PlayListTableView.register(PlayListTableViewCell.nib(), forCellReuseIdentifier: PlayListTableViewCell.identifier)
        PlayListTableView.register(TopTableView.nib(), forCellReuseIdentifier: TopTableView.identifier)
        PlayListTableView.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        PlayListTableView.dataSource = self
        PlayListTableView.delegate = self
        
        PlayListTableView.reloadData()
        loadPlaylists()
    }
   

}
extension PlaylistViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return playlists.count + 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
               guard let firstCell = tableView.dequeueReusableCell(withIdentifier: TopTableView.identifier, for: indexPath) as? TopTableView else {
                   return UITableViewCell()
               }
               firstCell.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
               firstCell.createPlaylistButtonTappedClosure = { [weak self] in
                            self?.showCreatePlaylistAlert()
                        }
               
                firstCell.configureCell()
               return firstCell
           } else {
               guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayListTableViewCell.identifier, for: indexPath) as? PlayListTableViewCell else {
                   return UITableViewCell()
               }
            cell.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
               let playlist = playlists[indexPath.row - 1]
               cell.nameLabel.text = playlist.name
              
               cell.removeButtonTappedClosure = { [weak self] in
                   self?.removePlaylist(atIndex: indexPath.row - 1)}
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
}
extension PlaylistViewController {
    func showCreatePlaylistAlert() {
        let alert = UIAlertController(title: "Create Playlist", message: "Enter playlist name", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        let createAction = UIAlertAction(title: "Create", style: .default) { [weak self] _ in
            guard let nameTextField = alert.textFields?.first, let name = nameTextField.text, !name.isEmpty else {
                self?.showErrorAlert(message: "Please enter playlist name")
                return
            }
            self?.createPlaylist(withName: name)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(createAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func createPlaylist(withName name: String) {
        let newPlaylist = Playlist(name: name, songs: [])
        playlists.append(newPlaylist)
        savePlaylists()
        PlayListTableView.reloadData()
        showSuccessAlert(message: "Đã tạo danh sách phát mới: \(name)")
    }
    
    func showSuccessAlert(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default
                                     , handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func savePlaylists() {
            let fileManager = FileManager.default
            guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                print("Failed to access document directory")
                return
            }

            let playlistsURL = documentsURL.appendingPathComponent("playlists.plist")

            do {
                let encodedData = try PropertyListEncoder().encode(playlists)
                try encodedData.write(to: playlistsURL)
            } catch {
                print("Failed to save playlists: \(error)")
            }
        }
    func loadPlaylists() {
            let fileManager = FileManager.default
            guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                print("Failed to access document directory")
                return
            }

            let playlistsURL = documentsURL.appendingPathComponent("playlists.plist")

            if let encodedData = try? Data(contentsOf: playlistsURL) {
                do {
                    let decodedPlaylists = try PropertyListDecoder().decode([Playlist].self, from: encodedData)
                    playlists = decodedPlaylists
                } catch {
                    print("Failed to load playlists: \(error)")
                }
            }
        }
    func removePlaylist(atIndex index: Int) {
        playlists.remove(at: index)
        savePlaylists()
        PlayListTableView.reloadData()
    }
}
