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
                            EmptyCoordinatorDelegate,
                            SearchCoordinatorDelegate {
    var childCoordinators = [Coordinator]()
    private var window: UIWindow?

    private lazy var appConfiguration = AppConfiguration()
    private lazy var apiDataTransferService: DataTransferService = {
        let configuration = APIDataNetworkConfiguration(
            baseURL: URL(
                string: appConfiguration.apiBaseURL)!)

        let apiDataNetwork = DefaultNetworkService(
            config: configuration)
        return DefaultDataTransferService(
            with: apiDataNetwork)
    }()

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

    private func tabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()

        let searchNC = searchNavigationController()
        searchNC.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(named: "tabbar_search"),
            tag: 1)

        tabBarController.viewControllers = [searchNC]
        tabBarController.tabBar.backgroundColor = .clear
        return tabBarController
    }

    private func searchNavigationController() -> UINavigationController {
        let coordinator = SearchCoordinator(
            apiDataTransferService: apiDataTransferService)

        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        let searchNC = coordinator.start()
        return searchNC
    }

    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
