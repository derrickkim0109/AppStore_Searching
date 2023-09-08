//
//  AppDetailHeaderView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/07.
//

import UIKit

final class AppDetailHeaderView: BaseView {
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                iconImageView,
                appInfoStackView
            ]
        )

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()

    private let iconImageView: CachedAsyncImageView = {
        let imageView = CachedAsyncImageView()
        imageView.setupBoarder(0.3)
        return imageView
    }()

    private lazy var appInfoStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                appTrackNameLabel,
                appSellerNameLabel,
                buttonStackView
            ]
        )

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 3
        return stackView
    }()

    private let appTrackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: 20,
            weight: .bold
        )

        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentHuggingPriority(
            .defaultLow,
            for: .horizontal
        )
        return label
    }()

    private let appSellerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: 12
        )
        label.textColor = .gray
        return label
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                fetchButtonView,
                buttonEmptyStackView,
                shareButtonView
            ]
        )

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()

    private let fetchButtonView = RoundedButtonView()

    private let buttonEmptyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let shareButtonView = ShareButtonView()

    private var urlString: String?

    override func setupDefault() {
        super.setupDefault()

        fetchButtonView.configure(
            title: "받기",
            backgroundColor: UIColor.fetchButtonBackgroundColor,
            fontSize: 15.0,
            cornerRadius: 15.0
        )

        fetchButtonView.button.addTarget(
            self,
            action: #selector(didTapFetchButton(_:)),
            for: .touchUpInside
        )
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(rootStackView)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(
                equalTo: topAnchor),
            rootStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            rootStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            rootStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(
                equalToConstant: 120),
            iconImageView.heightAnchor.constraint(
                equalTo: iconImageView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            fetchButtonView.button.widthAnchor.constraint(
                equalToConstant: 70),
            fetchButtonView.button.heightAnchor.constraint(
                equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            buttonEmptyStackView.widthAnchor.constraint(
                equalTo: buttonStackView.widthAnchor,
                multiplier: 0.66)
        ])
    }

    func configure(appItem: AppSearchItemModel) {
        let cachedIconImageInfo = CachedImageInfo(
            urlStr: appItem.artworkUrl512,
            cornerRadius: 20
        )

        iconImageView.configure(
            cachedIconImageInfo
        )

        appTrackNameLabel.text = appItem.trackName
        appSellerNameLabel.text = appItem.sellerName

        shareButtonView.configure(appItem: appItem)
        urlString = appItem.trackViewUrl
    }

    @objc private func didTapFetchButton(_ sender: UIButton) {
        guard let urlStr = urlString,
              let url = URL(string: urlStr) else {
            return
        }

        UIApplication.shared.open(
            url,
            options: [:],
            completionHandler: nil
        )
    }
}
