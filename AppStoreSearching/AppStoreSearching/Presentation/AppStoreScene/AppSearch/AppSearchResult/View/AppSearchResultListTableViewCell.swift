//
//  AppSearchResultListTableViewCell.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class AppSearchResultListTableViewCell: UITableViewCell {
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                iconImageView,
                infoStackView,
                fetchButtonView
            ]
        )

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    private let iconImageView: CachedAsyncImageView = {
        let imageView = CachedAsyncImageView()
        imageView.setupBoarder(0.3)
        return imageView
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                appNameLabel,
                genreTextLabel
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()

    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let genreTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.lightGray
        return label
    }()

    private let fetchButtonView = RoundedButtonView()
    private let appSearchInfoSummaryView = AppSearchInfoSummaryView()
    private let appScreenshotView = AppScreenshotView()

    private var urlString: String?

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )

        setupDefault()
        addUIComponents()
        configureLayouts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        iconImageView.remove()
        appSearchInfoSummaryView.remove()
        appNameLabel.text = nil
        genreTextLabel.text = nil
    }

    func configure(appItem: AppSearchItemModel) {
        let cachedIconImageInfo = CachedImageInfo(
            urlStr: appItem.artworkUrl512,
            cornerRadius: 10
        )

        iconImageView.configure(
            cachedIconImageInfo
        )

        appScreenshotView.configure(
            by: appItem.screenshotUrls
        )

        appNameLabel.text = appItem.trackName
        genreTextLabel.text = appItem.genres.first
        appSearchInfoSummaryView.configure(appItem)
        urlString = appItem.trackViewUrl
    }

    private func setupDefault() {
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

    private func addUIComponents() {
        [rootStackView,
         appSearchInfoSummaryView,
         appScreenshotView]
            .forEach{ contentView.addSubview($0) }
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(
                equalToConstant: 60),
            fetchButtonView.centerYAnchor.constraint(
                equalTo: iconImageView.centerYAnchor),
            infoStackView.widthAnchor.constraint(
                equalTo: rootStackView.widthAnchor,
                multiplier: 0.55)
        ])

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 18),
            rootStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 18),
            rootStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -18),

            rootStackView.heightAnchor.constraint(
                equalToConstant: 60)
        ])

        NSLayoutConstraint.activate([
            appSearchInfoSummaryView.topAnchor.constraint(
                equalTo: rootStackView.bottomAnchor,
                constant: 18),
            appSearchInfoSummaryView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 18),
            appSearchInfoSummaryView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -18),
            appSearchInfoSummaryView.heightAnchor.constraint(
                equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            appScreenshotView.topAnchor.constraint(
                equalTo: appSearchInfoSummaryView.bottomAnchor,
                constant: 18),
            appScreenshotView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor),
            appScreenshotView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 18),
            appScreenshotView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -18)
        ])

        NSLayoutConstraint.activate([
            fetchButtonView.button.widthAnchor.constraint(
                equalToConstant: 70),
            fetchButtonView.button.heightAnchor.constraint(
                equalToConstant: 30)
        ])
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

extension AppSearchResultListTableViewCell: ReusableView { }
