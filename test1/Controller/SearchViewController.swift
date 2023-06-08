//
//  SearchViewController.swift
//  test1
//
//  Created by Hung Vu on 28/04/2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchResults: [Song] = []
    
    var song: [Song] = []
    
    var isSearchResultsVisible = false

    
    @IBOutlet weak var discoverTable: UITableView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        discoverTable.register(TableViewCell.nib(), forCellReuseIdentifier:TableViewCell.identifier)
        
        discoverTable.isHidden = true

        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        searchBar.barTintColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        
        searchBar.delegate = self
        searchBar.tintColor = .black
     
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBackground]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white


        self.navigationController?.navigationBar.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor: UIColor.systemBackground,
                            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
                        ]
    }

}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchResultsVisible ? searchResults.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)

        let currentSong = searchResults[indexPath.row]
        cell.configure(with: currentSong)
        return cell;
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = searchResults[indexPath.row]
        self.navigationController?.pushViewController(TrackViewController.makeSelf(song: song,song1: self.searchResults,playlist: self.song), animated: true)

    }
    func search(query: String) {
           APICaller.shared.search(query: query) { [weak self] result in
               switch result {
               case .success(let songs):
                   self?.searchResults = songs
                   DispatchQueue.main.async {
                       self?.discoverTable.reloadData()
                   }
               case .failure(let error):
                   print("Error searching: \(error)")
               }
           }
       }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        searchBar.showsCancelButton = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            search(query: query)
        }
        
        discoverTable.isHidden = false
        isSearchResultsVisible = true
        image.isHidden = true
        label.isHidden = true
        discoverTable.reloadData()

    }
}
