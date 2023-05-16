//
//  ViewController.swift
//  test1
//
//  Created by Hung Vu on 05/04/2023.
//

import UIKit
import SwiftPageMenu

class HomeViewController: UIViewController {
    
    @IBOutlet weak var HomeTable: UITableView!
    
    var song: [Song] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        HomeTable.register(TableViewCell.nib(), forCellReuseIdentifier:TableViewCell.identifier)
        HomeTable.delegate = self
        HomeTable.dataSource = self
       
        fetchData()
    }
    func addToPlaylist(_ song: Song) {
            // Thêm logic để xử lý việc thêm bài hát vào danh sách phát của bạn tại đây
            print("Thêm bài hát vào danh sách phát: \(song.name)")
        }
        static func makeSelf() -> HomeViewController {
                let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let rootViewController: HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                                        return rootViewController
            }
    
    func fetchData() {
        APICaller.shared.getTrack { [weak self] result in
            switch result {
            case .success(let songs):
                self?.song = songs
                DispatchQueue.main.async {
                    self?.HomeTable.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }

}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return song.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for:indexPath) as! TableViewCell
        cell.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        let currentSong = song[indexPath.row]
        cell.configure(with: currentSong)
        
        cell.addButtonTappedClosure = { [weak self] in
                self?.addToPlaylist(currentSong)
            }



        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("tapped")
    }
    
}
