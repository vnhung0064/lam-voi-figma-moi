//
//  TableViewCell.swift
//  test1
//
//  Created by Hung Vu on 04/05/2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    @IBOutlet weak var avImage: UIImageView!
    
    @IBOutlet weak var SongName: UILabel!
    
    @IBOutlet weak var SingerName: UILabel!
    
    @IBOutlet weak var AddButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configuare(with image:UIImage){
        avImage.image  = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
    static func nib() -> UINib{
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
}
