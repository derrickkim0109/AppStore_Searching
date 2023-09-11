//
//  AppCoordinator.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start() -> UINavigationController
}

final class AppCoordinator: Coordinator,
                            SearchCoordinatorDelegate {
    var childCoordinators = [Coordinator]()
    private var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    @discardableResult
    func start() -> UINavigationController {
        let tabBarController = tabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        return UINavigationController()
    }

    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(
                    at: index
                )
                break
            }
        }
    }

    func showDetailViewController(
        at viewController: UIViewController,
        of item: AppSearchItemModel
    ) {
        let viewModel = AppDetailViewModel(
            appItem: item
        )
        let appDetailViewController = AppDetailViewController(
            viewModel: viewModel
        )

        viewController.navigationController?.navigationBar.prefersLargeTitles = false
        viewController.navigationController?.pushViewController(
            appDetailViewController,
            animated: true
        )
    }

    private func tabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()

        let searchNC = searchNavigationController()
        
        searchNC.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(
                systemName: "magnifyingglass"
            ),
            tag: 1)

        tabBarController.viewControllers = [searchNC]
        tabBarController.tabBar.backgroundColor = .clear
        return tabBarController
    }
    
    private func searchNavigationController() -> UINavigationController {
        let coordinator = SearchCoordinator()

        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        let searchNC = coordinator.start()
        return searchNC
    }
}
