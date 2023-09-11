//
//  AppDetailView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/07.
//

import UIKit

final class AppDetailView: BaseView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [appHeaderView,
                               appDetailSummaryView,
                               appDetailReleaseNoteView,
                               appDetailCarouselView,
                               appDescriptionView,
                               appDetailInfoView]
        )
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    private let appHeaderView = AppDetailHeaderView()

    private let appDetailSummaryView = AppDetailSummaryView()

    private let appDetailReleaseNoteView = AppDetailReleaseNoteView()

    private let appDetailCarouselView = AppDetailCarouselView()

    private let appDescriptionView = ExpandableLabelView()
    
    private let appDetailInfoView = AppDetailInfoView()


    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(scrollView)
        scrollView.addSubview(rootStackView)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 10),
            scrollView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -10)
        ])

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(
                equalTo: scrollView.topAnchor),
            rootStackView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor),
            rootStackView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor),

            rootStackView.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            appDetailSummaryView.heightAnchor.constraint(
                equalToConstant: 100)
        ])
    }

    func configure(appItem: AppSearchItemModel) {
        appHeaderView.configure(
            appItem: appItem
        )
        
        appDetailSummaryView.configure(
            appItem: appItem
        )

        appDetailReleaseNoteView.configure(
            appItem: appItem
        )

        if appItem.getScreenShots() {
            appDetailCarouselView.configure(
                appItem: appItem
            )
        }

        appDescriptionView.configure(
            text: appItem.description
        )
    }
}
