//
//  TagViewController.swift
//  test1
//
//  Created by Hung Vu on 30/05/2023.
//

import UIKit

class TagViewController: UIViewController {

    @IBOutlet weak var TV: UITableView!
    
    var song: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        TV.register(TableViewCell.nib(), forCellReuseIdentifier:TableViewCell.identifier)
        TV.delegate = self
        TV.dataSource = self
        
        fetchData()

    }
    func fetchData() {
        APICaller.shared.getTrackforTag{ [weak self] result in
            switch result {
            case .success(let songs):
                self?.song = songs
                DispatchQueue.main.async {
                    self?.TV.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    static func makeSelf() -> TagViewController {
                let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let rootViewController: TagViewController = storyboard.instantiateViewController(withIdentifier: "TagViewController") as! TagViewController
                                        return rootViewController
            }

   
}
extension TagViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return song.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for:indexPath) as! TableViewCell
        cell.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        let currentSong = song[indexPath.row]
        cell.configure(with: currentSong)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let song = song[indexPath.row]
        
        self.navigationController?.pushViewController(TrackViewController.makeSelf(song: song,song1: self.song,playlist: self.song), animated: true)
       
    }
}
