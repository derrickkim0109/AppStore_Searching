//
//  AppDetailViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

import UIKit

final class AppDetailViewController: BaseViewController<AppDetailViewModel> {
    private let appDetailView = AppDetailView()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        view.addSubview(appDetailView)
    }

    override func configureLayouts() {
        super.configureLayouts()

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

    override func bind() {
        super.bind()

        appDetailView.configure(appItem: viewModel.appItem)
    }
}
