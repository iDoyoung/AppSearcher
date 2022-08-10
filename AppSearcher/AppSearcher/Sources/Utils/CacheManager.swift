//
//  CacheManager.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/08.
//

import UIKit

final class CacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() { }
}
