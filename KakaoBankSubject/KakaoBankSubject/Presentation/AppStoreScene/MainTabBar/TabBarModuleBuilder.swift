//
//  TabBarModuleBuilder.swift
//  KakaoBankSubject
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class TabBarModuleBuilder {
    static func build(
        usingSubmodules submodules: TabBarRouter.Submodules) -> UITabBarController {
        let tabs = TabBarRouter.tabs(usingSubmodules: submodules)
        let tabBarController = MainTabBarViewController(tabs: tabs)
        tabBarController.tabBar.tintColor = UIColor.systemBlue
        return tabBarController
    }
}
