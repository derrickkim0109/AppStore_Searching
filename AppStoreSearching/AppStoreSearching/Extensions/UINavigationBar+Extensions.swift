//
//  UINavigationBar+Extensions.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/19.
//

import UIKit

extension UINavigationBar {
    func setShadow(hidden: Bool) {
        setValue(hidden, forKey: "hidesShadow")
    }
}
