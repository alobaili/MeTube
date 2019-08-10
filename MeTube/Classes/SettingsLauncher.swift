//
//  SettingsLauncher.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 10/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellID = "cellID"
    
    let cellHeight: CGFloat = 50
    
    var homeController: HomeController?
    
    let settings: [Setting] = {
        return [
            Setting(name: .settings, imageName: "settings"),
            Setting(name: .termsAndPrivacyPolicy, imageName: "privacy"),
            Setting(name: .sendFeedback, imageName: "feedback"),
            Setting(name: .help, imageName: "help"),
            Setting(name: .switchAccount, imageName: "switch_account"),
            Setting(name: .cancel, imageName: "cancel")
        ]
    }()
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    @objc func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBlankSpaceTap)))
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.alpha = 0
            window.addSubview(blackView)
            
            let collectionViewHeight: CGFloat = CGFloat(settings.count) * cellHeight
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
    
    @objc func handleDismiss(setting: Setting?) {
        if let window = UIApplication.shared.keyWindow {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.blackView.alpha = 0
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }) { didComplete in
                
                guard let setting = setting else { return }
                
                if setting.name != .cancel {
                    self.homeController?.showController(for: setting)
                }
            }
            
        }
    }
    
    @objc func handleBlankSpaceTap() {
        handleDismiss(setting: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension SettingsLauncher: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SettingsLauncher: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SettingsLauncher: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
