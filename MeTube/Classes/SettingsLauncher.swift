//
//  SettingsLauncher.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 10/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import UIKit

class SettingsLauncher {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .white
        return cv
    }()
    
    @objc func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.alpha = 0
            window.addSubview(blackView)
            
            let collectionViewHeight: CGFloat = 200
            let collectionViewWidth: CGFloat = window.frame.width
            let bottomOfScreenLocation = window.frame.height - collectionViewHeight
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: collectionViewWidth, height: collectionViewHeight)
            window.addSubview(collectionView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: bottomOfScreenLocation, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            })
        }
    }
    
    @objc func handleDismiss() {
        
        if let window = UIApplication.shared.keyWindow {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.blackView.alpha = 0
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            })
            
        }
    }
}
