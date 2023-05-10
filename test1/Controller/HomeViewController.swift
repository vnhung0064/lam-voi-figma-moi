//
//  ViewController.swift
//  test1
//
//  Created by Hung Vu on 05/04/2023.
//

import UIKit
import SwiftPageMenu


class HomeViewController: UIViewController {
    
    var song: [String] = []
    

    
    @IBOutlet weak var HomeTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        HomeTable.register(TableViewCell.nib(), forCellReuseIdentifier:TableViewCell.identifier)
        HomeTable.delegate = self
        HomeTable.dataSource = self
        fetchData()
    }
    static func makeSelf() -> HomeViewController {
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let rootViewController: HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                                    return rootViewController
        }
    func fetchData() {
        APICaller.shared.getTrack()
        }
    

    
}
extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return song.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for:indexPath)
        cell.backgroundColor = .systemBackground
        cell.textLabel?.text = song[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

