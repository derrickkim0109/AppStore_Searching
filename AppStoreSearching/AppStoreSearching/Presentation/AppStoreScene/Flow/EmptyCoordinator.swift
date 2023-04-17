//
//  EmptyCoordinator.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

import UIKit

protocol EmptyCoordinatorDelegate: AnyObject { }

class EmptyCoordinator: Coordinator,
                        EmptyViewControllerDelegate {
    weak var parentCoordinator: EmptyCoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    private var navigationController = UINavigationController()

    func start() -> UINavigationController {
        let viewController = setViewController()
        return setNavigationController(with: viewController)
    }

    private func setViewController() -> UIViewController {
        let viewController = EmptyViewController()

        viewController.coordinator = self
        return viewController
    }

    private func setNavigationController(
        with viewController: UIViewController) -> UINavigationController {
        navigationController.setViewControllers(
            [viewController],
            animated: false)
            
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.topItem?.title = "Empty"
        return navigationController
    }
}
