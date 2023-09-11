//
//  AppDetailReleaseNoteView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/07.
//

import UIKit

final class AppDetailReleaseNoteView: BaseView {
    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        return stackView
    }()

    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()

    private let expandableTextView = ExpandableLabelView()
    
    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(rootStackView)

        [contentStackView,
         expandableTextView]
            .forEach { rootStackView.addArrangedSubview($0) }
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
            expandableTextView.widthAnchor.constraint(
                equalTo: rootStackView.widthAnchor)
        ])
    }

    func configure(appItem: AppSearchItemModel) {
        setupReleaseNoteView(appItem: appItem)
    }

    private func setupReleaseNoteView(appItem: AppSearchItemModel) {
        let dividerView = makeDiverView(
            type: .horizontal
        )

        let titleLabel = makeUILabel(
            text: "새로운 기능",
            font: UIFont.systemFont(
                ofSize: 20,
                weight: .bold
            )
        )
        titleLabel.textAlignment = .left

        let versionLabel = makeUILabel(
            text: "버전 \(appItem.version)",
            font: UIFont.systemFont(
                ofSize: 14,
                weight: .medium
            )
        )
        versionLabel.textColor = .gray
        versionLabel.textAlignment = .left

        [titleLabel,
        versionLabel]
            .forEach { titleStackView.addArrangedSubview($0)}

        let spacerView = makeSpacerView()

        [titleStackView,
         spacerView]
            .forEach { contentStackView.addArrangedSubview($0) }

        if let lastReleasedDate = appItem.currentVersionReleaseDate.getLastReleasedDate() {
            let lastReleasedDateLabel = makeUILabel(
                text: "\(lastReleasedDate)",
                font: UIFont.systemFont(
                    ofSize: 15,
                    weight: .medium
                )
            )
            lastReleasedDateLabel.textColor = .gray


            contentStackView.addArrangedSubview(lastReleasedDateLabel)
        }

        expandableTextView.configure(text: appItem.releaseNotes)

        rootStackView.addArrangedSubview(dividerView)
    }

    private func makeSpacerView() -> UIView {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false

        let widthConstraint = spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: 240)

        NSLayoutConstraint.activate([
            widthConstraint
        ])

        return spacer
    }
}
