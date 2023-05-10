//
//  SettingTableViewCell.swift
//  test1
//
//  Created by Hung Vu on 09/05/2023.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"
    
    @IBOutlet weak var Icon: UIImageView!
        
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib{
        return UINib(nibName: "SettingTableViewCell", bundle: nil)
    }
}
