//
//  AppStoreSceneDIContainer.swift
//  KakaoBankSubject
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class AppStoreSceneDIContainer {
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Flow Coordinators
    func makeAppStoreMainFlowCoordinator(
        navigationController: UINavigationController) -> AppStoreMainFlowCoordinator {
            return AppStoreMainFlowCoordinator(
                navigationController: navigationController,
                dependencies: self)
        }
}

extension AppStoreSceneDIContainer {
    // MARK: - Use Cases


    // MARK: Repositories

}

extension AppStoreSceneDIContainer {
    func makeTabBarViewController(
        _ searchActions: RecentSearchViewModelActions) -> UITabBarController {
            let submodules = (
                today: makeTodayViewController(),
                games: makeGameViewController(),
                apps: makeAppViewController(),
                arcade: makeArcadeViewController(),
                search: makeRecentSearchViewController(searchActions)
            )

            let tabBarViewController = TabBarModuleBuilder.build(usingSubmodules: submodules)

            return tabBarViewController
        }

    func makeTodayViewController() -> EmptyViewController {
        let todayViewController = EmptyViewController()
        return todayViewController
    }

    func makeGameViewController() -> EmptyViewController {
        let gameViewController = EmptyViewController()
        return gameViewController
    }

    func makeAppViewController() -> EmptyViewController {
        let appViewController = EmptyViewController()
        return appViewController
    }

    func makeArcadeViewController() -> EmptyViewController {
        let arcadeViewController = EmptyViewController()
        return arcadeViewController
    }

    func makeRecentSearchViewController(
        _ actions: RecentSearchViewModelActions) -> RecentSearchViewController {
            let recentSearchViewController = RecentSearchViewController()
            return recentSearchViewController
        }
}

extension AppStoreSceneDIContainer: AppStoreMainFlowCoordinatorDependencies { }
