//
//  UIApplication.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import UIKit

extension UIApplication {
    func getCurrentUIWindow() -> UIWindow {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter({
                $0.activationState == .foregroundActive
            })
            .compactMap({
                $0 as? UIWindowScene
            })

        let window = connectedScenes.first?
            .windows
            .first {
                $0.isKeyWindow
            } ?? UIWindow()

        return window
    }
}
