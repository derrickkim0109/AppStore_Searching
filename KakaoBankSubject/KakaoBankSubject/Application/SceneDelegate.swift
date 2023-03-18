//
//  SceneDelegate.swift
//  KakaoBankSubject
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else {
                return
            }
            window = UIWindow(windowScene: windowScene)

            let navigationController = UINavigationController()

            window?.rootViewController = navigationController
            appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController,
                                                    appDIContainer: appDIContainer)
            appFlowCoordinator?.start()

            window?.makeKeyAndVisible()
        }
}
