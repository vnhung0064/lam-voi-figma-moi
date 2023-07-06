//
//  PlayListTableViewCell.swift
//  test1
//
//  Created by Hung Vu on 12/05/2023.
//
import SDWebImage
import UIKit

class PlayListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var PlaylistImage: UIImageView!
    @IBOutlet weak var RemoveButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var songcount: UILabel!
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
    func setLastSongAlbumImage(_ albumImageURL: String?) {
        if let imageURL = albumImageURL, let url = URL(string: imageURL) {
            PlaylistImage.sd_setImage(with: url, completed: nil)
        } else {
            // Handle the case when there is no valid album image
            PlaylistImage.image = UIImage(named: "Add Icon 1") // Set a placeholder image
        }
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "PlayListTableViewCell", bundle: nil)
    }
    @IBAction func removeButtonTapped(_ sender: Any) {
        removeButtonTappedClosure?()
    }
    
}
