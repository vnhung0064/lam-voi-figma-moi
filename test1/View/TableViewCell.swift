//
//  TableViewCell.swift
//  test1
//
//  Created by Hung Vu on 04/05/2023.
//

import UIKit
import SDWebImage
class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    var addButtonTappedClosure: (() -> Void)?
    
    @IBOutlet weak var avImage: UIImageView!
    
    @IBOutlet weak var SongName: UILabel!
    
    @IBOutlet weak var SingerName: UILabel!
    
    @IBOutlet weak var AddButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        SongName.textColor = UIColor(named: "Color")
        SingerName.textColor = UIColor(named: "Color")
        
        avImage.layer.cornerRadius = 4

    }
    
    func configuare(with image:UIImage){
        avImage.image  = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with song: Song) {
        SongName.text = "\(song.name)"
        SingerName.text = "\(song.artist_name)"
        if let imageURL = URL(string: song.album_image) {
                    avImage.sd_setImage(with: imageURL, completed: nil)
                }
        AddButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    @objc private func addButtonTapped(){
        addButtonTappedClosure?()
    }

    
    static func nib() -> UINib{
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
}
