//
//  AppScreenshotView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/31.
//

import UIKit

final class AppScreenshotView: BaseView {
    private let screenshotStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()

    override func setupDefault() {
        super.setupDefault()

        backgroundColor = .clear
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(screenshotStackView)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            screenshotStackView.topAnchor.constraint(
                equalTo: topAnchor),
            screenshotStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            screenshotStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            screenshotStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])
    }

    func configure(by previewImageList: [String]) {
        removeAll()

        makeCachedImageViews(by: previewImageList)
            .forEach { screenshotStackView.addArrangedSubview($0) }
    }

    func removeAll() {
        screenshotStackView.arrangedSubviews.forEach { view in
            screenshotStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }

    private func makeCachedImageViews(
        by screenshotURLs: [String]
    ) -> [CachedAsyncImageView] {
        return screenshotURLs
            .prefix(3)
            .map { makeScreenshotImageView(by: $0) }
    }

    private func makeScreenshotImageView(
        by url: String
    ) -> CachedAsyncImageView {
        let cachedInfo = CachedImageInfo(
            urlStr: url,
            cornerRadius: 20)

        let imageView = CachedAsyncImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.configure(cachedInfo)
        imageView.setupBoarder(0.2)

        return imageView
    }
}
