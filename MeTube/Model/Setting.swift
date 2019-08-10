//
//  Setting.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 10/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import Foundation

class Setting: NSObject {
    var name: SettingName
    var imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
