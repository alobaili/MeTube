//
//  API.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 12/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import Foundation

class API {
    static let shared = API()
    private init() {}
    
    func fetchVideos(completion: @escaping (Result<[Video],Error>) -> Void) {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print(error!)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String : Any]]
                
                var videos = [Video]()
                
                json.forEach({ (dictionary) in
                    var video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String : Any]
                    
                    var channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    video.channel = channel
                    
                    videos.append(video)
                })
                
                completion(.success(videos))
                
            } catch {
                completion(.failure(error))
            }
            
            }.resume()
    }
}
