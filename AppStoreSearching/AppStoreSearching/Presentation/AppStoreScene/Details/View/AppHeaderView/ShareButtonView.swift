//
//  ShareButtonView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/07.
//

import UIKit

final class ShareButtonView: BaseView {
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            UIImage(
                systemName: "square.and.arrow.up"
            ),
            for: .normal
        )
        button.tintColor = .systemBlue
        return button
    }()

    private var urlString: String?

    override func setupDefault() {
        super.setupDefault()

        button.addTarget(
            self,
            action: #selector(didTapShareButton(_:)),
            for: .touchUpInside)
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(button)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(
                equalTo: topAnchor),
            button.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            button.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            button.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])
    }

    func configure(appItem: AppSearchItemModel) {
        urlString = appItem.trackViewUrl
    }

    @objc private func didTapShareButton(_ sender: UIButton) {
        guard let urlStr = urlString,
              let shareURL = URL(string: urlStr) else {
            return
        }

        let activityVC = UIActivityViewController(
            activityItems: [shareURL],
            applicationActivities: nil
        )

        UIApplication.shared
            .getCurrentUIWindow()
            .rootViewController?
            .present(
                activityVC,
                animated: true,
                completion: nil
            )
    }
}
