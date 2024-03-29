//
//  TrendingCell.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 13/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        API.shared.fetchTrendingFeed { (result) in
            switch result {
            case .success(let videos):
                self.videos = videos
                DispatchQueue.main.async {
                    self.collcetionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
