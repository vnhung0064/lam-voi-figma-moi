//
//  PlayListTableViewCell.swift
//  test1
//
//  Created by Hung Vu on 12/05/2023.
//

import UIKit

class PlayListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var RemoveButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    static let identifier = "PlayListTableViewCell"
    var removeButtonTappedClosure: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "PlayListTableViewCell", bundle: nil)
    }
    @IBAction func removeButtonTapped(_ sender: Any) {
        removeButtonTappedClosure?()
    }
    
}
