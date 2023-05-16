//
//  TopTableView.swift
//  test1
//
//  Created by Hung Vu on 12/05/2023.
//

import UIKit

class TopTableView: UITableViewCell {
    
    @IBOutlet weak var Add: UIButton!
    static let identifier = "TopTableView"
    

    var createPlaylistButtonTappedClosure: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib{
        return UINib(nibName: "TopTableView", bundle: nil)
    }
    func configureCell() {
            // ...
            Add.addTarget(self, action: #selector(createPlaylistButtonTapped), for: .touchUpInside)
        }
    @objc private func createPlaylistButtonTapped() {
            createPlaylistButtonTappedClosure?()
        }
}
