//
//  Images.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/10/01.
//

import UIKit

enum Images: String {
    case search = "magnifyingglass"

    var image: UIImage {
        switch self {
        case .search:
            return UIImage(systemName: self.rawValue) ?? UIImage()
        }
    }
}
