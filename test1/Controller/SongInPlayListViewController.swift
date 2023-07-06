
//  SongInPlayListViewController.swift
//  test1
//
//  Created by Hung Vu on 30/05/2023.
//

import UIKit

class SongInPlayListViewController: UIViewController {
    
    var songs: [Song] = []
    var playlists: [Playlist] = []
    var index: Int = 0
    var isEditingPlaylist = false
    var selectedIndices: [Int] = []
    var button: UIButton!
    @IBOutlet weak var TablePlaylist: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TablePlaylist.register(SongTableViewCell.nib(), forCellReuseIdentifier:SongTableViewCell.identifier)
        TablePlaylist.dataSource = self
        TablePlaylist.delegate = self
        fetchdatafromUserdefault()
        TablePlaylist.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
    
        button = UIButton()
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "Select"), for: .normal)

        let select = UIBarButtonItem()
    
        select.customView = button
        navigationItem.rightBarButtonItems = [select]
        
        
    }

    @objc func selectButtonTapped() {
        isEditingPlaylist = !isEditingPlaylist
        
        if isEditingPlaylist {
            showDeleteButton()
            if button.currentImage?.isEqual(UIImage(named: "Select")) ?? false {
                button.setImage(UIImage(named: "Done"), for: .normal)
            }
        } else {
            hideCheckboxes()
            hideDeleteButton()
            selectedIndices.removeAll()
            if button.currentImage?.isEqual(UIImage(named: "Done")) ?? false {
                button.setImage(UIImage(named: "Select"), for: .normal)
            }
        }
        
        TablePlaylist.reloadData()
    }


    func hideCheckboxes() {
        for cell in TablePlaylist.visibleCells {
            if let songCell = cell as? SongTableViewCell {
                songCell.CheckboxButton.isHidden = true
            }
        }
    }
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    private func showDeleteButton() {
        deleteButton.frame = CGRect(x: 0, y: view.bounds.height - 200/2 + 3, width: view.bounds.width, height: 50)
        view.addSubview(deleteButton)
    }

    private func hideDeleteButton() {
        deleteButton.removeFromSuperview()
    }
    @objc func deleteButtonTapped() {
        guard isEditingPlaylist else {
            return
        }

        // Lấy playlist đang được chọn
        guard index < playlists.count else {
            return
        }
        var selectedPlaylist = playlists[index]

        // Xoá các bài hát được chọn
        var updatedSongs: [Song] = []
        var updatedSelectedIndices: [Int] = []

        for (index, song) in songs.enumerated() {
            if !selectedIndices.contains(index) {
                updatedSongs.append(song)
            } else {
                updatedSelectedIndices.append(index)
            }
        }
        selectedPlaylist.songs = updatedSongs
        playlists[index] = selectedPlaylist

        // Cập nhật danh sách bài hát và chỉ mục được chọn
        songs = updatedSongs


        // Lưu danh sách playlists vào UserDefaults
        savePlaylistsToUserDefaults()
        


        // Reload dữ liệu trong table view
        TablePlaylist.reloadData()
    }

    func savePlaylistsToUserDefaults() {
        do {
            let encodedPlaylists = try JSONEncoder().encode(playlists)
            UserDefaults.standard.set(encodedPlaylists, forKey: key_playlists_userdefault)
            print("Playlists saved to UserDefaults")
            
            print(playlists)
        } catch {
            print("Failed to save playlists to UserDefaults: \(error)")
        }
    }
  
    static func makeSelf(index: Int) -> SongInPlayListViewController {
                let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let rootViewController: SongInPlayListViewController = storyboard.instantiateViewController(withIdentifier: "SongInPlayListViewController") as! SongInPlayListViewController
                rootViewController.index = index
        
                                        return rootViewController
            }
    func fetchdatafromUserdefault() {
        if let encodedData = UserDefaults.standard.data(forKey: key_playlists_userdefault) {
            do {
                let decodedPlaylists = try JSONDecoder().decode([Playlist].self, from: encodedData)
                playlists = decodedPlaylists
                print("Playlists loaded from UserDefaults")
                
                // Kiểm tra xem có playlist nào được chọn không
                let selectedPlaylist = playlists[index]
                songs = selectedPlaylist.songs
                    TablePlaylist.reloadData()
//                    print(selectedPlaylist)
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
        
        let isSelected = selectedIndices.contains(indexPath.row)

        cell.configure(with: song, isEditingPlaylist: isEditingPlaylist, isSelected: isSelected)
        
        cell.checkboxTappedHandler = { [weak self] in
                    guard let self = self else { return }
                    
                    if isSelected {
                        self.selectedIndices.removeAll(where: { $0 == indexPath.row })
                    } else {
                        self.selectedIndices.append(indexPath.row)
                    }
                }

       
               return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
       
            let selectedSong = songs[indexPath.row]
            navigationController?.pushViewController(TrackViewController.makeSelf(song: selectedSong, song1: songs, playlist: []), animated: true)
    }

   

    
    
}
