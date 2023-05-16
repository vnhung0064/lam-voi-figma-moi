//
//  AddtoPlaylistViewController.swift
//  test1
//
//  Created by Hung Vu on 15/05/2023.
//

import UIKit

class AddtoPlaylistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlayListAdd.dataSource = self
        PlayListAdd.delegate = self
        
        PlayListAdd.register(PlayListTableViewCell.nib(), forCellReuseIdentifier: PlayListTableViewCell.identifier)

    }
    
    @IBOutlet weak var PlayListAdd: UITableView!
    

}
extension AddtoPlaylistViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayListTableViewCell.identifier, for: indexPath) as? PlayListTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .red
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
}
