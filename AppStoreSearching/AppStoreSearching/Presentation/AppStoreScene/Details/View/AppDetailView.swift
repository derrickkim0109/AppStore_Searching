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
            arrangedSubviews: [
                appHeaderView,
                appDetailSummaryView,
                appDetailReleaseNoteView,
                appDetailCarouselView,
                appDescriptionContainerView,
                appDetailInfoView
            ]
        )
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()

    private let appHeaderView = AppDetailHeaderView()

    private let appDetailSummaryView = AppDetailSummaryView()

    private let appDetailReleaseNoteView = AppDetailReleaseNoteView()

    private let appDetailCarouselView = AppDetailCarouselView()

    private lazy var topUnderlineView = makeDiverView(
        type: .horizontal
    )

    private let appDescriptionContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let appDescriptionView = ExpandableLabelView()
    
    private let appDetailInfoView = AppDetailInfoView()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(scrollView)
        scrollView.addSubview(rootStackView)
        appDescriptionContainerView.addSubview(topUnderlineView)
        appDescriptionContainerView.addSubview(appDescriptionView)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
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
                equalToConstant: 100),
            appDetailInfoView.heightAnchor.constraint(
                equalToConstant: 400)
        ])

        NSLayoutConstraint.activate([
            topUnderlineView.topAnchor.constraint(
                equalTo: appDescriptionContainerView.topAnchor),
            topUnderlineView.leadingAnchor.constraint(
                equalTo: appDescriptionContainerView.leadingAnchor,
                constant: 15),
            topUnderlineView.trailingAnchor.constraint(
                equalTo: appDescriptionContainerView.trailingAnchor,
                constant: -15)
        ])

        NSLayoutConstraint.activate([
            appDescriptionView.topAnchor.constraint(
                equalTo: topUnderlineView.bottomAnchor,
                constant: 20),
            appDescriptionView.bottomAnchor.constraint(
                equalTo: appDescriptionContainerView.bottomAnchor),
            appDescriptionView.leadingAnchor.constraint(
                equalTo: appDescriptionContainerView.leadingAnchor,
                constant: 15),
            appDescriptionView.trailingAnchor.constraint(
                equalTo: appDescriptionContainerView.trailingAnchor,
                constant: -15)
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

        if appItem.isVisibleScreenShots {
            appDetailCarouselView.configure(
                appItem: appItem
            )
        }

        appDescriptionView.configure(
            text: appItem.description
        )

        appDetailInfoView.configure(
            appItem: appItem
        )
    }
}
