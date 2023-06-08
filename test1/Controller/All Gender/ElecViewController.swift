//
//  ElecViewController.swift
//  test1
//
//  Created by Hung Vu on 30/05/2023.
//

import UIKit

class ElecViewController: UIViewController {
    
    var song: [Song] = []
    
    @IBOutlet weak var TA2: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        TA2.register(TableViewCell.nib(), forCellReuseIdentifier:TableViewCell.identifier)
        TA2.delegate = self
        TA2.dataSource = self
        
        fetchData()

        // Do any additional setup after loading the view.
    }
    func fetchData() {
        APICaller.shared.getTrackforTag1{ [weak self] result in
            switch result {
            case .success(let songs):
                self?.song = songs
                DispatchQueue.main.async {
                    self?.TA2.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    static func makeSelf() -> ElecViewController {
                let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let rootViewController: ElecViewController = storyboard.instantiateViewController(withIdentifier: "ElecViewController") as! ElecViewController
                                        return rootViewController
            }


}
extension ElecViewController:UITableViewDelegate, UITableViewDataSource{
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
