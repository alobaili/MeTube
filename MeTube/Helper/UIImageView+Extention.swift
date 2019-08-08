//
//  UIImageView+Extention.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 08/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageUsingURLString(urlString: String) {
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
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                self.image = imageToCache
            }
        }.resume()
    }
}
