//
//  AppsInfoListTableViewCell.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class AppsInfoListTableViewCell: UITableViewCell {
    private let bag = AnyCancelTaskBag()

    private let iconImageView: IconImageView = {
        let imageView = IconImageView()
        return imageView
    }()

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

    private lazy var screenshotStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstScreenshotImageView,
                                                       secondScreenshotImageView,
                                                       thirdScreenshotImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = Const.ten
        return stackView
    }()

    private let firstScreenshotImageView: ScreenshotImageView = {
        let imageView = ScreenshotImageView()
        return imageView
    }()

    private let secondScreenshotImageView: ScreenshotImageView = {
        let imageView = ScreenshotImageView()
        return imageView
    }()

    private let thirdScreenshotImageView: ScreenshotImageView = {
        let imageView = ScreenshotImageView()
        return imageView
    }()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?) {
            super.init(
                style: style,
                reuseIdentifier: reuseIdentifier)
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
         screenshotStackView].forEach{ contentView.addSubview($0) }
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
                equalToConstant: Const.sixty)
        ])

        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(
                equalTo: iconImageView.topAnchor),
            infoStackView.bottomAnchor.constraint(
                equalTo: iconImageView.bottomAnchor),
            infoStackView.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: Const.ten)
        ])

        NSLayoutConstraint.activate([
            fetchButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Const.twenty),
            fetchButton.centerYAnchor.constraint(
                equalTo: iconImageView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            screenshotStackView.topAnchor.constraint(
                equalTo: iconImageView.bottomAnchor,
                constant: Const.eighteen),
            screenshotStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor),
            screenshotStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Const.eighteen),
            screenshotStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Const.eighteen)
        ])

        NSLayoutConstraint.activate([
            infoStackView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: Const.zeroPointFour),
            userCountLabel.centerYAnchor.constraint(
                equalTo: starRatingView.centerYAnchor),
            firstScreenshotImageView.heightAnchor.constraint(
                equalToConstant: Const.twoHundredfifty),
            secondScreenshotImageView.heightAnchor.constraint(
                equalToConstant: Const.twoHundredfifty),
            thirdScreenshotImageView.heightAnchor.constraint(
                equalToConstant: Const.twoHundredfifty)
        ])
    }

    private func setupImageCaching(
        _ imageView: UIImageView,
        from imageURL: String) async {
            do {
                try await imageView.setImageUrl(imageURL)
            } catch (let error) {
                await AlertControllerBulider.Builder()
                    .setMessag(error.localizedDescription)
                    .setConfrimText(Const.confirm)
                    .build()
                    .present()
            }
        }

    private func setupImageViews(_ appInfo: AppInfoEntity) {
        Task { [weak self] in
            guard let `self` = self else {
                return
            }

            await self.setupImageCaching(
                self.iconImageView,
                from: appInfo.icon)
        }.store(in: bag)

        Task { [weak self] in
            guard let `self` = self else {
                return
            }

            let screenshotImageViews = [
                firstScreenshotImageView,
                secondScreenshotImageView,
                thirdScreenshotImageView]

            for (index, imageView) in screenshotImageViews.enumerated() {
                await self.setupImageCaching(
                    imageView,
                    from: appInfo.screenshots[index + Const.one])

            }
        }.store(in: bag)
    }

    func configure(appInfo: AppInfoEntity) {
        setupImageViews(appInfo)
        appNameLabel.text = appInfo.name
        starRatingView.rating = round(
            appInfo.averageUserRating * Const.oneHundred) / Const.oneHundred
        
        userCountLabel.text = appInfo.userRatingCount.formattedNumber
        genreTextLabel.text = appInfo.genre

        if userCountLabel.text == Const.zero
            || starRatingView.isHidden {
            starRatingStackView.isHidden = true
        }
    }

    private enum Const {
        static let zero = "0"
        static let zeroPointFour = 0.4
        static let one = 1
        static let two = 2.0
        static let ten = 10.0
        static let thirteen = 13.0
        static let sixteen = 16.0
        static let eighteen = 18.0
        static let twenty = 20.0
        static let sixty = 60.0
        static let oneHundred = 100.0
        static let twoHundredfifty = 250.0
        static let confirm = "확인"
    }
}

extension AppsInfoListTableViewCell: ReusableView { }
