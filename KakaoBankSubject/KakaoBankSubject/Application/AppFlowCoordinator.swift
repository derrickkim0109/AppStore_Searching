//
//  AppFlowCoordinator.swift
//  KakaoBankSubject
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let appStoreSceneDIContainer = appDIContainer.makeAppStoreSceneDIContainer()
        let flow = appStoreSceneDIContainer.makeAppStoreMainFlowCoordinator(
            navigationController: navigationController)
        flow.start()
    }
}
