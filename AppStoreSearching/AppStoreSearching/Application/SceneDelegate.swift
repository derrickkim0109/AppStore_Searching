//
//  SceneDelegate.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: Coordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(
            windowScene: windowScene
        )

        let navigationController = UINavigationController()
        coordinator = AppCoordinator(rootViewController: navigationController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        coordinator?.start()
    }
}
