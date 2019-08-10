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
    
    @objc func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.alpha = 0
            window.addSubview(blackView)
            
            UIView.animate(withDuration: 0.3) {
                self.blackView.alpha = 1
            }
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.3) {
            self.blackView.alpha = 0
        }
    }
}
