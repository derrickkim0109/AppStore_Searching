//
//  EmptyViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

protocol EmptyViewControllerDelegate: AnyObject { }

final class EmptyViewController: UIViewController {
    weak var coordinator: EmptyViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
