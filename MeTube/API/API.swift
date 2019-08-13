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
    
    let baseURL = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping (Result<[Video],Error>) -> Void) {
        fetchFeedFor(urlString: "\(baseURL)/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping (Result<[Video],Error>) -> Void) {
        fetchFeedFor(urlString: "\(baseURL)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionsFeed(completion: @escaping (Result<[Video],Error>) -> Void) {
        fetchFeedFor(urlString: "\(baseURL)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedFor(urlString: String, completion: @escaping (Result<[Video],Error>) -> Void) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print(error!)
                return
            }
            do {
                let json = try JSONDecoder().decode([Video].self, from: data)
                
                completion(.success(json))
                
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
