//
//  ShareButtonView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/07.
//

import UIKit

final class ShareButtonView: BaseView {
    private let shareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(
            systemName: "square.and.arrow.up"
        )
        return imageView
    }()

    private var urlString: String?

    override func setupDefault() {
        super.setupDefault()

        let tabGestureCancelReportButton = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapShareImageView(_:)))

        shareImageView.addGestureRecognizer(tabGestureCancelReportButton)
        shareImageView.isUserInteractionEnabled = true
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(shareImageView)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            shareImageView.topAnchor.constraint(
                equalTo: topAnchor),
            shareImageView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            shareImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            shareImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor),

            shareImageView.heightAnchor.constraint(
                equalToConstant: 20)
        ])
    }

    func configure(appItem: AppSearchItemModel) {
        urlString = appItem.trackViewUrl
    }

    @objc private func didTapShareImageView(_ sender: UIGestureRecognizer) {
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
