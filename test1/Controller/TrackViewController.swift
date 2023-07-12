//
//  TrackViewController.swift
//  test1
//
//  Created by Hung Vu on 17/05/2023.
//

import UIKit
import AVFoundation
import SDWebImage

var TrackPlayCurrent : TrackViewController?

class TrackViewController: UIViewController {
    
    var currentTrackIndex = 0

    var song1: [Song] = []
    
    var playlist: [Song] = []
    
    var song: Song?
    
    var player: AVPlayer?
    
    var timer: Timer?

    var isRepeating = false

   // var miniTrackVC: MiniTrackViewController?
    
    @IBOutlet weak var SongImage: UIImageView!
    
    @IBOutlet weak var SongNameLb: UILabel!
    
    @IBOutlet weak var SinggerNameLb: UILabel!
    
    @IBOutlet weak var Slider: UISlider!
    
    @IBOutlet weak var currentTime: UILabel!
    
    @IBOutlet weak var TotalTime: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var PLayButton: UIButton!
    
    @IBOutlet weak var RepeateButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    
    @IBOutlet weak var addtoPlaylist: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SongNameLb.text = song?.name
        SinggerNameLb.text = song?.artist_name
        SinggerNameLb.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
        
        if let imageURL = URL(string: song!.album_image) {
            SongImage.sd_setImage(with: imageURL, completed: nil)
        }
        
        if let iden = song?.id {
            let urlaudio = URL(string: "https://mp3l.jamendo.com/?trackid=\(iden)&format=mp31&from=app-devsite")
            print(urlaudio!)
            let playerItem = AVPlayerItem(url: urlaudio!)
            player = AVPlayer(playerItem: playerItem)
            player?.play()
        }
        updatePlayerTimeLabels()
        Slider.tintColor = UIColor(red: 0.51, green: 0.37, blue: 0.98, alpha: 1)
        
        view.backgroundColor = UIColor(red: 0.208, green: 0.2, blue: 0.361, alpha: 1)
        
        startTimer()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "add-circle"), style: .done, target: self, action: nil)
        
        navigationItem.title = "Play Song"
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkSongEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)

        TrackPlayCurrent = self

}
    
    
    
    static func makeSelf(song:Song, song1: [Song],playlist: [Song]) -> TrackViewController {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController: TrackViewController = storyboard.instantiateViewController(withIdentifier: "TrackViewController") as! TrackViewController
        rootViewController.song = song
        rootViewController.song1 = song1
        rootViewController.playlist = playlist

        return rootViewController
    }
    
    
    @IBAction func PlayClicked(_ sender: UIButton) {
        switch player?.timeControlStatus {
        case .paused:
            player?.play()
            (sender as AnyObject).setImage(UIImage(named: "pause"), for: .normal)
        case .playing, .waitingToPlayAtSpecifiedRate:
            player?.pause()
            (sender as AnyObject).setImage(UIImage(named: "play"), for: .normal)
        default:
            // Set the button image to "play" in the default case
            (sender as AnyObject).setImage(UIImage(named: "pause"), for: .normal)
        }

        
    }
    @IBAction func addToPlaylistButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(PlaylistaddSongViewController.makeSelf(currentsong: song!), animated: true)
        
    }

    
    func formatTimeString(_ time: Double) -> String {
        if time.isFinite {
            let minutes = Int(time / 60)
            let seconds = Int(time.truncatingRemainder(dividingBy: 60))
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return "00:00"
        }
    }

   @objc func updatePlayerTimeLabels() {
        guard let player = player else {
            return
        }
        
        let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? .zero)
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        
        let durationString = formatTimeString(durationSeconds)
        let currentTimeString = formatTimeString(currentTimeSeconds)
        
        DispatchQueue.main.async {
            self.TotalTime.text = durationString
            self.currentTime.text = currentTimeString
            
            let progress = Float(currentTimeSeconds / durationSeconds)
            self.Slider.value = progress
            

        }
    }
    var doituong: Any?
    @IBAction func RepeateTapped(_ sender: Any?) {
        isRepeating = !isRepeating
        
            if isRepeating {
                let duration = player?.currentItem?.duration ?? CMTime.zero
                let time = CMTime(seconds: 0.1, preferredTimescale: 100)
                let times = [NSValue(time: duration - time), NSValue(time: duration)]
                RepeateButton.setImage(UIImage(named: "repeateOn"), for: .normal)
                
                doituong = player?.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
                    self?.player?.seek(to: .zero)
                    self?.player?.play()

                }
                
            } else {
                player?.removeTimeObserver(doituong as Any)
                RepeateButton.setImage(UIImage(named: "repeateOff"), for: .normal)
            }
        print("tapped")
    }
    func playNextTrack() {
        
        if !song1.isEmpty {
            currentTrackIndex += 1

            if currentTrackIndex >= song1.count {
                currentTrackIndex = 0
            }
            let nextSong = song1[currentTrackIndex]
            
            // Thực hiện các thay đổi cần thiết để chuyển đến bài hát tiếp theo, ví dụ: cập nhật UI, thay đổi URL audio, vv.
            SongNameLb.text = nextSong.name
            SinggerNameLb.text = nextSong.artist_name

            if let imageURL = URL(string: nextSong.album_image) {
                SongImage.sd_setImage(with: imageURL, completed: nil)
            }
            let iden = nextSong.id
            let urlaudio = URL(string: "https://mp3l.jamendo.com/?trackid=\(iden)&format=mp31&from=app-devsite")
            let playerItem = AVPlayerItem(url: urlaudio!)
            player?.replaceCurrentItem(with: playerItem)
            player?.play()
            
        }
    }

    @IBAction func NextTracKTapped(_ sender: Any) {
        playNextTrack()
        print("tapped")
    }
    func playPreviousTrack() {
        if !song1.isEmpty {
            currentTrackIndex -= 1
            
            if currentTrackIndex < 0 {
                currentTrackIndex = song1.count - 1
            }
            
            let previousSong = song1[currentTrackIndex]
            
            // Thực hiện các thay đổi cần thiết để chuyển đến bài hát trước đó, ví dụ: cập nhật UI, thay đổi URL audio, vv.
            SongNameLb.text = previousSong.name
            SinggerNameLb.text = previousSong.artist_name
            
            if let imageURL = URL(string: previousSong.album_image) {
                SongImage.sd_setImage(with: imageURL, completed: nil)
            }
            
            let iden = previousSong.id
            let urlaudio = URL(string: "https://mp3l.jamendo.com/?trackid=\(iden)&format=mp31&from=app-devsite")
            let playerItem = AVPlayerItem(url: urlaudio!)
            player?.replaceCurrentItem(with: playerItem)
            player?.play()
        }
    }

    @IBAction func PreviousTapped(_ sender: Any) {
        playPreviousTrack()
    }
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let percentage = Slider.value
        guard let duration = player?.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        player!.seek(to: seekTime)
    }
    func startTimer() {
        // Đảm bảo rằng Timer không đang chạy trước khi tạo mới
        stopTimer()
        
        // Tạo Timer với khoảng thời gian cập nhật là 1 giây
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updatePlayerTimeLabels()
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func checkSongEnd() {
        player!.seek(to: CMTime.zero)
        player!.pause()
        playNextTrack()
    }
    
   
}
