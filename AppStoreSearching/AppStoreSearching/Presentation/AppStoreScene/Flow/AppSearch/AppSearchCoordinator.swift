//
//  AppSearchCoordinator.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

import UIKit

final class AppSearchCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]

    private let dependencies: AppSearchDependencyContainerDelegate

    init(
        navigationController: UINavigationController,
        dependencies: AppSearchDependencyContainerDelegate
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.childCoordinators = []
    }

    func start() {
        showSearchViewController()
    }
}

extension AppSearchCoordinator {
    func showSearchViewController() {
        let viewController = dependencies.makeAppSearchViewController()
        viewController.coordinator = self
        viewController.title = "검색"
        navigationController.navigationBar.prefersLargeTitles = true

        navigationController.pushViewController(
            viewController,
            animated: true
        )
    }

    func connectAppDetailFlow(appItem: AppSearchItemModel) {
        let appDetailDependencyContainer: AppDetailDependencyContainerDelegate = AppDetailDependencyContainer()
        let productDetailCoordinator = AppDetailCoordinator(
            item: appItem,
            navigationController: navigationController,
            dependencies: appDetailDependencyContainer
        )

        productDetailCoordinator.delegate = self
        productDetailCoordinator.start()
        self.childCoordinators.append(productDetailCoordinator)
    }
}

extension AppSearchCoordinator: CoordinatorDelegate, AppSearchViewControllerDelegate {
    func didFinish(childCoordinator: Coordinator) {
        if childCoordinator is AppDetailCoordinator {
            navigationController.popViewController(animated: false)
        }
    }
}
