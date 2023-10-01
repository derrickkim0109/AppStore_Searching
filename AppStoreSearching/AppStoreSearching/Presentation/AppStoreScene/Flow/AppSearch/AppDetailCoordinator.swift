//
//  AppDetailCoordinator.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/10/01.
//

import UIKit

final class AppDetailCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]

    private let dependencies: AppDetailDependencyContainerDelegate
    private var item: AppSearchItemModel?

    init(
        navigationController: UINavigationController,
        dependencies: AppDetailDependencyContainerDelegate
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.childCoordinators = []
    }

    convenience init(
        item: AppSearchItemModel,
        navigationController: UINavigationController,
        dependencies: AppDetailDependencyContainerDelegate
    ) {
        self.init(
            navigationController: navigationController,
            dependencies: dependencies
        )

        self.item = item
    }

    func start() {
        self.showAppDetailViewController(of: item)
    }
}

extension AppDetailCoordinator {
    func showAppDetailViewController(of item: AppSearchItemModel?) {
        let viewController = dependencies.makeAppDetailViewController(of: item)
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension AppDetailCoordinator: CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        navigationController.popViewController(animated: false)
    }
}
