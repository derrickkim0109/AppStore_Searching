//
//  MainTabBarViewController.swift
//  KakaoBankSubject
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

typealias Tabs = (
    today: UIViewController,
    games: UIViewController,
    apps: UIViewController,
    arcade: UIViewController,
    search: UIViewController
)

final class MainTabBarViewController: UITabBarController {
    init(tabs: Tabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.today,
                           tabs.games,
                           tabs.apps,
                           tabs.arcade,
                           tabs.search]
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
