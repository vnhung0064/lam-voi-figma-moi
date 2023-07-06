import UIKit

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ImageSong: UIImageView!
    @IBOutlet weak var SongName: UILabel!
    @IBOutlet weak var CheckboxButton: UIButton!
    @IBOutlet weak var SingerName: UILabel!
    
    static let identifier = "SongTableViewCell"
    
    var checkboxTappedHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with song: Song, isEditingPlaylist: Bool, isSelected: Bool) {
        SongName.text = song.name
        SingerName.text = song.artist_name
        if let imageURL = URL(string: song.album_image) {
            ImageSong.sd_setImage(with: imageURL, completed: nil)
        }
        
        CheckboxButton.isHidden = !isEditingPlaylist
        CheckboxButton.isSelected = isSelected
    }
    
    @IBAction func checkboxTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        let imageName = sender.isSelected ? "checked" : "uncheck"
        sender.setImage(UIImage(named: imageName), for: .normal)
        checkboxTappedHandler?()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SongTableViewCell", bundle: nil)
    }
    
}
