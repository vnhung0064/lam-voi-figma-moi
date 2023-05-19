//
//  TrackViewController.swift
//  test1
//
//  Created by Hung Vu on 17/05/2023.
//

import UIKit
import AVFoundation
import SDWebImage

class TrackViewController: UIViewController {
    
    
    var song: Song?
    
    var player: AVPlayer?
    
    var timer: Timer?

    @IBOutlet weak var SongImage: UIImageView!
    
    @IBOutlet weak var SongNameLb: UILabel!
    
    @IBOutlet weak var SinggerNameLb: UILabel!
    
    @IBOutlet weak var Slider: UISlider!
    
    @IBOutlet weak var currentTime: UILabel!
    
    @IBOutlet weak var RdButton: UIButton!
    @IBOutlet weak var TotalTime: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var PLayButton: UIButton!
    
    
    @IBOutlet weak var RepeatButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SongNameLb.text = song?.name
        SinggerNameLb.text = song?.artist_name
        SinggerNameLb.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
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
    }
    
    static func makeSelf(song:Song) -> TrackViewController {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController: TrackViewController = storyboard.instantiateViewController(withIdentifier: "TrackViewController") as! TrackViewController
        rootViewController.song = song
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
            
            if currentTimeString >= durationString{
                self.playNextSong()
            }

        }
    }
    
    func playNextSong() {
        guard let currentSong = song else {
                return
            }
            
            guard let currentIndex = song.firstIndex(where: { $0.id == currentSong.id }) else {
                return
            }
            
            let nextIndex = (currentIndex + 1) % song.count
            let nextSong = song[nextIndex]
            
            // Play the next song
            playSong(nextSong)
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
   
}
