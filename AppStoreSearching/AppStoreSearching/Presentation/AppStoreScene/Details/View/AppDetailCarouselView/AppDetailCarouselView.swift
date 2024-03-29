//
//  AppDetailCarouselView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/07.
//

import UIKit

final class AppDetailCarouselView: BaseView {
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                makeTitleLabelView("미리보기"),
                iPhoneStackView,
                iPadStackView,
                iPhoneAndIPadSupportView
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()

    private lazy var iPhoneStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                iPhoneCarouselView,
                iPhoneSupportView
            ]
        )
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    private lazy var iPhoneCarouselView: CarouselView = {
        let carouselView = CarouselView(
            itemSize: Const.iPhoneItemSize,
            itemSpacing: Const.itemSpacing,
            type: .iPhone
        )
        return carouselView
    }()

    private lazy var iPhoneSupportView = makeSupportedView(
        title: "iPhone",
        imageName: "iphone"
    )

    private lazy var iPadStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                iPadCarouselView,
                iPadSupportView
            ]
        )
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isHidden = true
        stackView.spacing = 10
        return stackView
    }()

    private lazy var iPadSupportView = makeSupportedView(
        title: "iPad",
        imageName: "ipad"
    )

    private lazy var iPadCarouselView: CarouselView = {
        let carouselView = CarouselView(
            itemSize: Const.iPadItemSize,
            itemSpacing: Const.itemSpacing,
            type: .iPad
        )
        return carouselView
    }()

    private lazy var iPhoneAndIPadSupportView = makeIPhoneAndIPadSupportView()

    private var isExpanded: Bool = false {
        didSet {
            iPadStackView.isHidden = !isExpanded
            iPhoneAndIPadSupportView.isHidden = isExpanded
            iPhoneSupportView.isHidden = !isExpanded
            iPadSupportView.isHidden = !isExpanded
        }
    }

    override func setupDefault() {
        super.setupDefault()

        let tabGestureSupportView = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapSupportView(_:))
        )

        iPhoneAndIPadSupportView.addGestureRecognizer(tabGestureSupportView)
        iPhoneAndIPadSupportView.isUserInteractionEnabled = true
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
            iPhoneCarouselView.heightAnchor.constraint(
                equalToConstant: 500),
            iPadCarouselView.heightAnchor.constraint(
                equalToConstant: 350)
        ])
    }

    func configure(appItem: AppSearchItemModel) {
        iPhoneCarouselView.applyDataSource(
            type: .iPhone,
            data: appItem.screenshotUrls
        )

        iPadCarouselView.applyDataSource(
            type: .iPad,
            data: appItem.ipadScreenshotUrls
        )

        iPhoneSupportView.isHidden = showExpandableButton(
            by: appItem.ipadScreenshotUrls
        )

        iPhoneAndIPadSupportView.isHidden = !showExpandableButton(
            by: appItem.ipadScreenshotUrls
        )
    }

    private func makeSupportedView(
        title: String,
        imageName: String
    ) -> UIView {
        let imageView = makeSupportImageView(imageName)

        let titleLabel = makeUILabel(
            text: title,
            font: UIFont.systemFont(
                ofSize: 12, weight: .bold
            ),
            textAlignment: .natural
        )

        let containerView = UIView()
        containerView.isHidden = true

        let stackView = UIStackView(
            arrangedSubviews: [
                imageView,
                titleLabel
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10

        containerView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: containerView.topAnchor),
            stackView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 20),
            stackView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor)
        ])

        return containerView
    }

    private func makeIPhoneAndIPadSupportView() -> UIView {
        let iphoneImageView = makeSupportImageView("iphone")
        let ipadImageView = makeSupportImageView("ipad")
        let chevronImageView = makeSupportImageView("chevron.down")

        let titleLabel = makeUILabel(
            text: "iPhone및 iPad용 앱",
            font: UIFont.systemFont(
                ofSize: 12, weight: .bold
            ),
            textAlignment: .natural
        )

        let containerView = UIView()

        let stackView = UIStackView(
            arrangedSubviews: [
                iphoneImageView,
                ipadImageView,
                titleLabel
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10

        [stackView,
         chevronImageView]
            .forEach { containerView.addSubview($0) }

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: containerView.topAnchor),
            stackView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 20),
            stackView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(
                equalTo: containerView.topAnchor),
            chevronImageView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor),
            chevronImageView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -20)
        ])

        return containerView
    }

    private func showExpandableButton(
        by item: [String]
    ) -> Bool {
        return !isExpanded && !item.isEmpty
    }

    @objc private func didTapSupportView(_ sender: UIGestureRecognizer) {
        isExpanded = true
    }

    private enum Const {
        static let iPhoneItemSize = CGSize(
            width: 260,
            height: 500
        )

        static let iPadItemSize = CGSize(
            width: 260,
            height: 350
        )

        static let itemSpacing = 24.0
    }
}
