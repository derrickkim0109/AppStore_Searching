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
                makeTitleLabelView(),
                iphoneStackView,
                ipadStackView,
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

    private lazy var iphoneStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                iphoneCarouselView,
                iPhoneSupportView
            ]
        )
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    private lazy var iphoneCarouselView: CarouselView = {
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

    private lazy var ipadStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                ipadCarouselView,
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

    private lazy var ipadCarouselView: CarouselView = {
        let carouselView = CarouselView(
            itemSize: Const.iPadItemSize,
            itemSpacing: Const.itemSpacing,
            type: .iPad
        )
        return carouselView
    }()

    private lazy var iPhoneAndIPadSupportView = makeIPhoneAndIPadSupportView()

    private lazy var bottomUnderlineView = makeDiverView(
        type: .horizontal
    )

    private var isExpanded: Bool = false {
        didSet {
            ipadStackView.isHidden = !isExpanded
            iPhoneAndIPadSupportView.isHidden = isExpanded
            iPhoneSupportView.isHidden = !isExpanded
            iPadSupportView.isHidden = !isExpanded
        }
    }

    override func setupDefault() {
        super.setupDefault()


        let tabGestureCancelReportButton = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapSupportView(_:))
        )

        iPhoneAndIPadSupportView.addGestureRecognizer(tabGestureCancelReportButton)
        iPhoneAndIPadSupportView.isUserInteractionEnabled = true
    }

    override func addUIComponents() {
        super.addUIComponents()

        [rootStackView,
         bottomUnderlineView]
            .forEach { addSubview($0) }
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
            bottomUnderlineView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: 10),
            bottomUnderlineView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 15),
            bottomUnderlineView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -15)
        ])

        NSLayoutConstraint.activate([
            iphoneCarouselView.heightAnchor.constraint(
                equalToConstant: 500),
            ipadCarouselView.heightAnchor.constraint(
                equalToConstant: 350)
        ])
    }

    func configure(appItem: AppSearchItemModel) {
        iphoneCarouselView.applyDataSource(
            type: .iPhone,
            data: appItem.screenshotUrls
        )

        ipadCarouselView.applyDataSource(
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

    private func makeTitleLabelView() -> UIView {
        let containerView = UIView()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "미리보기"
        label.font = UIFont.systemFont(
            ofSize: 20,
            weight: .bold
        )

        containerView.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(
                equalTo: containerView.topAnchor),
            label.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor),
            label.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 15),
            label.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor)
        ])

        return containerView
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
