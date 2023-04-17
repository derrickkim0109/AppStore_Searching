//
//  AppDescriptionViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

import UIKit

final class AppDescriptionViewController: UIViewController {
    private let rootScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = Const.zero
        return label
    }()

    private let appDescription: String

    init(appDescription: String) {
        self.appDescription = appDescription
        
        super.init(
            nibName: nil,
            bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
        view.backgroundColor = .systemBackground
        view.addSubview(rootScrollView)
        rootScrollView.addSubview(appDescriptionLabel)
        configureLayouts()
        appDescriptionLabel.text = appDescription
        setupNavigationController()
    }

    private func setupNavigationController() {
        navigationItem.title = Const.title
        navigationController?.navigationBar.backgroundColor = UIColor.systemGray6
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: Const.close,
            style: .done,
            target: self,
            action: #selector(didTapClose(_:)))
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            rootScrollView.topAnchor.constraint(
                equalTo: view.topAnchor),
            rootScrollView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            rootScrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            rootScrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            appDescriptionLabel.topAnchor.constraint(
                equalTo: rootScrollView.topAnchor),
            appDescriptionLabel.leadingAnchor.constraint(
                equalTo: rootScrollView.leadingAnchor),
            appDescriptionLabel.trailingAnchor.constraint(
                equalTo: rootScrollView.trailingAnchor),
            appDescriptionLabel.bottomAnchor.constraint(
                equalTo: rootScrollView.bottomAnchor),

            appDescriptionLabel.widthAnchor.constraint(
                equalTo: rootScrollView.widthAnchor)
        ])
    }

    @objc private func didTapClose(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    private enum Const {
        static let zero = 0
        static let title = "앱 설명"
        static let close = "닫기"
    }
}
