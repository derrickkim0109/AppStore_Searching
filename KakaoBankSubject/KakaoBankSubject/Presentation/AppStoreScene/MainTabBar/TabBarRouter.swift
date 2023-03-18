//
//  TabBarRouter.swift
//  KakaoBankSubject
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit
final class TabBarRouter {
    var view: UIViewController
    typealias Submodules = (
        today: UIViewController,
        games: UIViewController,
        apps: UIViewController,
        arcade: UIViewController,
        search: UIViewController
    )

    init(view: UIViewController) {
        self.view = view
    }
}

extension TabBarRouter {
    static func tabs(usingSubmodules submodules: Submodules) -> Tabs {
        let todayTabBarItem = UITabBarItem(
            title: "투데이",
            image: UIImage(named: "tabbar_today")?.withRenderingMode(.alwaysTemplate),
            tag: 11)
        let gamesTabBarItem = UITabBarItem(
            title: "게임",
            image: UIImage(named: "tabbar_games")?.withRenderingMode(.alwaysTemplate),
            tag: 12)
        let appsTabBarItem = UITabBarItem(
            title: "앱",
            image: UIImage(named: "tabbar_apps")?.withRenderingMode(.alwaysTemplate),
            tag: 13)
        let arcadeTabBarItem = UITabBarItem(
            title: "Arcade", image: UIImage(named: "tabbar_arcade")?.withRenderingMode(.alwaysTemplate),
            tag: 14)
        let searchTabBarItem = UITabBarItem(
            title: "검색", image: UIImage(named: "tabbar_search")?.withRenderingMode(.alwaysTemplate),
            tag: 15)

        submodules.today.tabBarItem = todayTabBarItem
        submodules.games.tabBarItem = gamesTabBarItem
        submodules.apps.tabBarItem = appsTabBarItem
        submodules.arcade.tabBarItem = arcadeTabBarItem
        submodules.search.tabBarItem = searchTabBarItem

        return (
            today: submodules.today,
            games: submodules.games,
            apps: submodules.apps,
            arcade: submodules.arcade,
            search: submodules.search
        )
    }
}
