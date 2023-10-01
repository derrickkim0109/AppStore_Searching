//
//  TabBarPageType.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/10/01.
//

import UIKit

enum TabBarPageType: Int, CaseIterable {
    case search = 0

    var tabBarItem: UITabBarItem {
        switch self {
        case .search:
            return UITabBarItem(
                title: "검색",
                image: Images.search.image.withTintColor(.gray),
                selectedImage: Images.search.image.withTintColor(.systemBlue)
            )
        }
    }
}
