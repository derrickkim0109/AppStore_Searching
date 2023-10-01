//
//  AppCoordinator.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

import UIKit

final class AppCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]

    init(rootViewController: UINavigationController) {
        self.navigationController = rootViewController
        self.childCoordinators = []
    }

    func start() {
        connectTabBarFlow()
    }
}

extension AppCoordinator {
    func connectTabBarFlow() {
        self.navigationController.popToRootViewController(animated: true)

        let tabBarCoordinator = TabBarCoordinator(
            navigationController: navigationController
        )
        
        tabBarCoordinator.delegate = self
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
}

extension AppCoordinator: CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        navigationController.popToRootViewController(animated: true)
        connectTabBarFlow()
    }
}
