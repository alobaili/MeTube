//
//  UIImageView+Extention.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 08/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    var imageURLString: String?
    
    /// Loads an image from a url string and sets it as the image for the `UIImageView`.
    ///
    /// When this function is first called, it checks if the image is already saved in the image cache. If it is, it assign's it as the `UIImageView`'s image. Otherwise, a `URLSession` data task is created using the shared session and the image is fetched from this data task. The fetched image is then assigned as the `UIImageView`s image and saved in the image cache.
    /// - Parameter urlString: A string representing the URL of the image to be loaded.
    func loadImageUsingURLString(urlString: String) {
        imageURLString = urlString
        
        let url = URL(string: urlString)
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data)
                
                if self.imageURLString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
        }.resume()
    }
}
