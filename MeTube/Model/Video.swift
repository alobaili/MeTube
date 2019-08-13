//
//  Video.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 08/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import Foundation

struct Video: Codable {
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: Int?
    var uploadDate: Date?
    var channel: Channel?
    var duration: Int?
}
