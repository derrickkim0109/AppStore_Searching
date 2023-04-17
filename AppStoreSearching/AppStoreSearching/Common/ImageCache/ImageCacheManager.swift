//
//  ImageCacheManager.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/19.
//

import UIKit

final class ImageCacheManager {
    static var shared = NSCache<NSString, UIImage>()
    private init() {}
}
