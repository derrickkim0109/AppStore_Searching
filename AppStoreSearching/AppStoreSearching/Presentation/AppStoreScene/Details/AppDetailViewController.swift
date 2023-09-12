//
//  AppDetailViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

import UIKit

final class AppDetailViewController: UIViewController {
    private let appDetailView = AppDetailView()

    private let appItem: AppSearchItemModel

    init(
        appItem: AppSearchItemModel
    ) {
        self.appItem = appItem

        super.init(
            nibName: nil,
            bundle: nil
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addUIComponents()
        configureLayouts()

        appDetailView.configure(
            appItem: appItem
        )
    }

    func addUIComponents() {
        view.addSubview(appDetailView)
    }

    func configureLayouts() {
        NSLayoutConstraint.activate([
            appDetailView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            appDetailView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            appDetailView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            appDetailView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
