//
//  TabBarCoordinator.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/10/01.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator]

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
        self.childCoordinators = []
    }

    func start() {
        let pages: [TabBarPageType] = TabBarPageType.allCases
        let controllers: [UINavigationController] = pages.map {
            createTabBarNavigationController(of: $0)
        }

        configureTabBarController(with: controllers)
    }
}

private extension TabBarCoordinator {
    private func configureTabBarController(with viewControllers: [UIViewController]) {
        tabBarController.selectedIndex = 0
        tabBarController.tabBar.tintColor = .systemBlue

        tabBarController.setViewControllers(
            viewControllers,
            animated: true
        )

        navigationController.setNavigationBarHidden(
            true,
            animated: false
        )

        navigationController.pushViewController(
            tabBarController,
            animated: true
        )
    }

    func createTabBarNavigationController(
        of page: TabBarPageType
    ) -> UINavigationController {
        let tabBarNavigationController = UINavigationController()
        tabBarNavigationController.tabBarItem = page.tabBarItem
        
        tabBarNavigationController.setNavigationBarHidden(
            false,
            animated: false
        )

        connectTabCoordinator(
            of: page,
            to: tabBarNavigationController
        )

        return tabBarNavigationController
    }

    func connectTabCoordinator(
        of page: TabBarPageType,
        to tabBarNavigationController: UINavigationController
    ) {
        switch page {
        case .search: connectSearchFlow(to: tabBarNavigationController)
        }
    }

    func connectSearchFlow(to tabBarNavigationController: UINavigationController) {
        let appSearchDependencyContainer: AppSearchDependencyContainerDelegate = AppSearchDependencyContainer()
        let mainCoordinator = AppSearchCoordinator(
            navigationController: tabBarNavigationController,
            dependencies: appSearchDependencyContainer
        )
        
        mainCoordinator.start()
        childCoordinators.append(mainCoordinator)
    }
}

extension TabBarCoordinator: CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        self.navigationController.popToRootViewController(animated: false)
        self.finish()
    }
}
