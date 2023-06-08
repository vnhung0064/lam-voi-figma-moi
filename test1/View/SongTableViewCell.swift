//
//  SongTableViewCell.swift
//  test1
//
//  Created by Hung Vu on 05/06/2023.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ImageSong: UIImageView!
    @IBOutlet weak var SongName: UILabel!
    
    @IBOutlet weak var SingerName: UILabel!
    static let identifier = "SongTableViewCell"


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with song: Song) {
        SongName.text = "\(song.name)"
        SingerName.text = "\(song.artist_name)"
        if let imageURL = URL(string: song.album_image) {
                    ImageSong.sd_setImage(with: imageURL, completed: nil)
                }
        
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "SongTableViewCell", bundle: nil)
    }
    
}
