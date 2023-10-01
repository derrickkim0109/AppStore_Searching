//
//  AppDetailDependencyContainer.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/10/01.
//

import UIKit

protocol AppDetailDependencyContainerDelegate {
    func makeAppDetailViewController(
        of item: AppSearchItemModel?
    ) -> UIViewController
}

final class AppDetailDependencyContainer: AppDetailDependencyContainerDelegate {
    init() { }

    func makeAppDetailViewController(
        of item: AppSearchItemModel?
    ) -> UIViewController {
        guard let item = item else {
            return UIViewController()
        }

        return AppDetailViewController(appItem: item)
    }
}
