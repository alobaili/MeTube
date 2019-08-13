//
//  VideoLauncher.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 13/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import UIKit

class VideoLauncher {
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width, y: keyWindow.frame.height, width: 1, height: 1)
            keyWindow.addSubview(view)
            
            // 16 * 9 is the aspect ratio
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }) { (didFinishAnimation) in
                // hide the status bar by rising the keywindow level to the level of the status bar.
                // this makes the status bar fade out
                keyWindow.windowLevel = UIWindow.Level.statusBar
            }
        }
    }
}
