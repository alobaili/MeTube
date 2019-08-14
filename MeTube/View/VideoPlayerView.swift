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
    
    var player: AVPlayer?
    var isPlaying = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayerView()
        
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
        }
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
    
}
