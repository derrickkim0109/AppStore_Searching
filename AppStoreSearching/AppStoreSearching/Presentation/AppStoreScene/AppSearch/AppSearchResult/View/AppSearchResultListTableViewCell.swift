//
//  AppSearchResultListTableViewCell.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class AppSearchResultListTableViewCell: UITableViewCell {
    private let bag = AnyCancelTaskBag()

    private let iconImageView = CachedAsyncImageView()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appNameLabel,
                                                       genreTextLabel,
                                                       starRatingStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = Const.two
        return stackView
    }()

    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Const.sixteen)
        return label
    }()

    private let genreTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.lightGray
        return label
    }()

    private lazy var starRatingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starRatingView,
                                                       userCountLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Const.ten
        return stackView
    }()

    private let starRatingView: StarRatingView = {
        let view = StarRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let userCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Const.thirteen)
        label.textColor = .lightGray
        return label
    }()

    private let fetchButton: FetchButton = {
        let button = FetchButton()
        return button
    }()

    private let appScreenshotView = AppScreenshotView()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )

        bind()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func bind() {
        setupViews()
        configureLayouts()
    }

    private func setupViews() {
        [iconImageView,
         infoStackView,
         fetchButton,
         appScreenshotView].forEach{ contentView.addSubview($0) }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        iconImageView.remove()
        appNameLabel.text = nil
        starRatingView.rating = 0.0
        userCountLabel.text = nil
        genreTextLabel.text = nil
        starRatingStackView.isHidden = false
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Const.twenty),
            iconImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Const.twenty),

            iconImageView.widthAnchor.constraint(
                equalToConstant: 55)
        ])

        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(
                equalTo: iconImageView.topAnchor),
            infoStackView.bottomAnchor.constraint(
                equalTo: iconImageView.bottomAnchor),
            infoStackView.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: Const.ten),

            infoStackView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: Const.zeroPointFour)
        ])

        NSLayoutConstraint.activate([
            fetchButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Const.twenty),
            fetchButton.centerYAnchor.constraint(
                equalTo: iconImageView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            appScreenshotView.topAnchor.constraint(
                equalTo: iconImageView.bottomAnchor,
                constant: Const.eighteen),
            appScreenshotView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor),
            appScreenshotView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Const.eighteen),
            appScreenshotView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Const.eighteen)
        ])

        NSLayoutConstraint.activate([
            userCountLabel.centerYAnchor.constraint(
                equalTo: starRatingView.centerYAnchor)
        ])
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
        starRatingView.rating = round(
            appItem.averageUserRating * Const.oneHundred) / Const.oneHundred
        
        userCountLabel.text = appItem.userRatingCount.formattedNumber
        genreTextLabel.text = appItem.genres.first

        if userCountLabel.text == Const.zeroStr
            || starRatingView.isHidden {
            starRatingStackView.isHidden = true
        }
    }

    private enum Const {
        static let zeroStr = "0"
        static let zeroPointFour = 0.4
        static let two = 2.0
        static let ten = 10.0
        static let thirteen = 13.0
        static let sixteen = 16.0
        static let eighteen = 18.0
        static let twenty = 20.0
        static let oneHundred = 100.0
        static let twoHundredfifty = 250.0
    }
}

extension AppSearchResultListTableViewCell: ReusableView { }
