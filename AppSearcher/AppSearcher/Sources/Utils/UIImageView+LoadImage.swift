//
//  UIImageView+LoadImage.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/08.
//

import UIKit

extension UIImageView {
    func loadImage(url: String) {
        let cachedKey = NSString(string: url)
        
        if let cachedImage = CacheManager.shared.object(forKey: cachedKey) {
            self.image = cachedImage
        } else {
            guard let url = URL(string: url) else { return }
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else { return }
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.image = image
                    CacheManager.shared.setObject(image, forKey: cachedKey)
                }
            }
        }
    }
}
