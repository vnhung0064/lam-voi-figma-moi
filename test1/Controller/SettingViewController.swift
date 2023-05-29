//
//  SettingViewController.swift
//  test1
//
//  Created by Hung Vu on 09/05/2023.
//

import UIKit

class SettingViewController: UIViewController {
    
    let Titles: [String] = ["Feedback", "Rate Us","Share with Friends"]
    
    let DataImage = ["message","like","share"]
    @IBOutlet weak var SettingTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingTable.register(SettingTableViewCell.nib(), forCellReuseIdentifier:SettingTableViewCell.identifier)
        SettingTable.dataSource = self
        SettingTable.delegate = self
        view.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        SettingTable.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        
        self.navigationController?.navigationBar.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor: UIColor.white,
                            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
                        ]

        
    }
    

    

}
extension SettingViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath)
        
        cell.textLabel?.text = Titles[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(DataImage[indexPath.row]).png")
        cell.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
       
        cell.textLabel?.textColor = .white
        
        

        return cell
    }
    
    
    
}
