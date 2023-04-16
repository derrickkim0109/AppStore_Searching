//
//  UIViewController+Extensions.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

extension UIViewController {
    func add(childViewController: UIViewController) {
        addChild(childViewController)
        childViewController.view.setupCenter(in: view)
        childViewController.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
