//
//  ViewController.swift
//  MusicApp
//
//  Created by Инкара on 01.11.2025.
//

import UIKit
import AVFoundation


struct Track {
    let title: String
    let artist: String
    let coverName: String
    let fileName: String
}

class ViewController: UIViewController {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    
    //плеер и таймер для слайдера
    var player: AVAudioPlayer?
    var timer: Timer?
    
    //список треков и текущий
    var tracks: [Track]=[]
    var currentIndex = 0
   
    // режим Shuffle
    var isShuffleOn = false
    // Repeat Mode: 0 = off, 1 = all, 2 = one
    var repeatMode = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tracks = [
                Track(title: "The Weeknd", artist: "São Paulo", coverName: "cover1", fileName: "song1"),
                Track(title: "Shape", artist: "Sugababes", coverName: "cover2", fileName: "song2"),
                Track(title: "Hot(radio version)", artist: "Inna", coverName: "cover3", fileName: "song3"),
                Track(title: "I never feel so right(radio mix)", artist: "Ben Delay", coverName: "cover4", fileName: "song4"),
                Track(title: "Amazing", artist: "Inna", coverName: "cover5", fileName: "song5")
            ]
            
            // Загружаем первый трек
            loadTrack(index: currentIndex)
        
    }
    
    
    func loadTrack(index: Int) {
        let track = tracks[index]
        
        // Обновляем UI
        titleLabel.text = track.title
        artistLabel.text = track.artist
        coverImageView.image = UIImage(named: track.coverName)
        
        // Загружаем музыку
        if let url = Bundle.main.url(forResource: track.fileName, withExtension: "mp3") {
            player = try? AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
        }
        
        // Обновляем длительность
        durationLabel.text = formatTime(player?.duration ?? 0)
                progressSlider.value = 0
                currentTimeLabel.text = "0:00"
        // Запускаем таймер для обновления слайдера
                startTimer()

    }
    
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            guard let player = self.player else { return }
            self.currentTimeLabel.text = self.formatTime(player.currentTime)
            if player.duration > 0 {
                self.progressSlider.value = Float(player.currentTime / player.duration)
            }
        }
    }

    
    @IBAction func sliderChanged(_ sender: UISlider) {
        guard let player = player else { return }
        player.currentTime = Double(sender.value) * player.duration
        currentTimeLabel.text = formatTime(player.currentTime)

    }
    
    
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        guard let player = player else { return }
           if player.isPlaying {
               player.pause()
               playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
           } else {
               player.play()
               playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
           }

    }
    
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if isShuffleOn {
                currentIndex = Int.random(in: 0..<tracks.count)
            } else {
                currentIndex = (currentIndex + 1) % tracks.count
            }
            loadTrack(index: currentIndex)
            player?.play()
        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    
    @IBAction func previousTapped(_ sender: UIButton) {
        if isShuffleOn {
            currentIndex = Int.random(in: 0..<tracks.count)
        } else {
            currentIndex = (currentIndex - 1 + tracks.count) % tracks.count
        }
        loadTrack(index: currentIndex)
        player?.play()
        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)

    }
    
    
    @IBAction func shuffleTapped(_ sender: UIButton) {
        isShuffleOn.toggle()
            let imageName = isShuffleOn ? "shuffle.circle.fill" : "shuffle"
            shuffleButton.setImage(UIImage(systemName: imageName), for: .normal)

    }
    
    
    
    @IBAction func repeatTapped(_ sender: UIButton) {
        repeatMode = (repeatMode + 1) % 3
            switch repeatMode {
            case 0: repeatButton.setImage(UIImage(systemName: "repeat"), for: .normal)
            case 1: repeatButton.setImage(UIImage(systemName: "repeat.circle.fill"), for: .normal)
            case 2: repeatButton.setImage(UIImage(systemName: "repeat.1"), for: .normal)
            default: break
            }

    }
}


    
    
    
