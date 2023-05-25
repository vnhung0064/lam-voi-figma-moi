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
    var currentTrackIndex = 0

    var song1: [Song] = []
    
    var song: Song?
    
    var player: AVPlayer?
    
    var timer: Timer?

    var isRepeating = false

    
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
    
    static func makeSelf(song:Song, song1: [Song]) -> TrackViewController {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController: TrackViewController = storyboard.instantiateViewController(withIdentifier: "TrackViewController") as! TrackViewController
        rootViewController.song = song
        rootViewController.song1 = song1
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
            
            

        }
    }
    var doituong: Any?
    @IBAction func RepeateTapped(_ sender: Any?) {
        isRepeating = !isRepeating
            
            if isRepeating {
                let duration = player?.currentItem?.duration ?? CMTime.zero
                let time = CMTime(seconds: 0.1, preferredTimescale: 100)
                let times = [NSValue(time: duration - time), NSValue(time: duration)]
                
                doituong = player?.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
                    self?.player?.seek(to: .zero)
                    self?.player?.play()
                }
            } else {
                player?.removeTimeObserver(doituong)
            }
        print("tapped")
    }
    func playNextTrack() {
        
        if !song1.isEmpty {
            currentTrackIndex += 1

            if currentTrackIndex >= song1.count {
                currentTrackIndex = 0
            }
            print(song1)

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
extension TrackViewController: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playNextTrack()
    }
}
