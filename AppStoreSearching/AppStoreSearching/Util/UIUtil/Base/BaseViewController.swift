//
//  BaseViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/22.
//

import UIKit
import Combine

class BaseViewController<T>: UIViewController, BaseViewControllerProtocol {
    let viewModel: T
    let bag = AnyCancelTaskBag()
    var cancellable: Set<AnyCancellable> = []

    required init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupDefault()
        addUIComponents()
        configureLayouts()
        bind()
    }

    func setupDefault() { }
    func addUIComponents() { }
    func configureLayouts() { }
    func bind() { }
}
