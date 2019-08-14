//
//  VideoPlayerView.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 13/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    let pauseAndPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(togglePauseAndPlay), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        let pauseImage = UIImage(named: "pause")
        button.setImage(pauseImage, for: .normal)
        button.tintColor = .white
        button.isHidden = true
        return button
    }()
    
    lazy var videoLengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        return label
    }()
    
    lazy var videoCurrentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        return label
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "slider_thumb_image"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    var player: AVPlayer?
    var isPlaying = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayerView()
        setupGradientLayer()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        controlsContainerView.addSubview(pauseAndPlayButton)
        NSLayoutConstraint.activate([
            pauseAndPlayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pauseAndPlayButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            pauseAndPlayButton.widthAnchor.constraint(equalToConstant: 50),
            pauseAndPlayButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        controlsContainerView.addSubview(videoLengthLabel)
        NSLayoutConstraint.activate([
            videoLengthLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            videoLengthLabel.widthAnchor.constraint(equalToConstant: 50),
            videoLengthLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        controlsContainerView.addSubview(videoCurrentTimeLabel)
        NSLayoutConstraint.activate([
            videoCurrentTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            videoCurrentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            videoCurrentTimeLabel.widthAnchor.constraint(equalToConstant: 50),
            videoCurrentTimeLabel.heightAnchor.constraint(equalToConstant: 24)
            
        ])
        
        controlsContainerView.addSubview(videoSlider)
        NSLayoutConstraint.activate([
            videoSlider.trailingAnchor.constraint(equalTo: videoLengthLabel.leadingAnchor),
            videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor),
            videoSlider.leadingAnchor.constraint(equalTo: videoCurrentTimeLabel.trailingAnchor),
            videoSlider.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            if player?.status == .readyToPlay {
                activityIndicatorView.stopAnimating()
                controlsContainerView.backgroundColor = .clear
                pauseAndPlayButton.isHidden = false
                isPlaying = true
            }
        }
        
        if keyPath == "currentItem.loadedTimeRanges" {
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let secondsText = Int(seconds.truncatingRemainder(dividingBy: 60))
                let minutsText = String(format: "%02d", Int(seconds / 60))
                videoLengthLabel.text = "\(minutsText):\(secondsText)"
            }
        }
    }
    
    fileprivate func setupPlayerView() {
        backgroundColor = .black
        let urlString = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            layer.addSublayer(playerLayer)
            playerLayer.frame = frame
            player?.play()
            
            // observe when the player is ready (frames are being rendered)
            player?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    @objc func togglePauseAndPlay() {
        if isPlaying {
            player?.pause()
            pauseAndPlayButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            pauseAndPlayButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    @objc func handleSliderChange() {
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (didFinishSeek) in
                // Maybe do something here later...
            })
        }
    }
    
}
