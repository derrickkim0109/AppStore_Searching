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
        stackView.spacing = 0
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
                equalTo: leadingAnchor,
                constant: 10),
            rootStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -10)
        ])

        NSLayoutConstraint.activate([
            contentStackView.widthAnchor.constraint(
                equalTo: rootStackView.widthAnchor),
            expandableTextView.widthAnchor.constraint(
                equalTo: rootStackView.widthAnchor)
        ])
    }

    func configure(appItem: AppSearchItemModel) {
        setupReleaseNoteView(appItem: appItem)
    }

    private func setupReleaseNoteView(appItem: AppSearchItemModel) {

        let titleLabel = makeUILabel(
            text: "새로운 기능",
            font: UIFont.systemFont(
                ofSize: 20,
                weight: .bold
            ),
            textAlignment: .center
        )
        titleLabel.textAlignment = .left

        let versionLabel = makeUILabel(
            text: "버전 \(appItem.version)",
            font: UIFont.systemFont(
                ofSize: 14,
                weight: .medium
            ),
            textAlignment: .center
        )
        versionLabel.textColor = .gray
        versionLabel.textAlignment = .left

        [titleLabel,
         versionLabel]
            .forEach { titleStackView.addArrangedSubview($0)}

        contentStackView.addArrangedSubview(titleStackView)

        if let lastReleasedDate = appItem.currentVersionReleaseDate.getLastReleasedDate() {
            let lastReleasedDateLabel = makeUILabel(
                text: "\(lastReleasedDate)",
                font: UIFont.systemFont(
                    ofSize: 15,
                    weight: .medium
                ),
                textAlignment: .center
            )
            lastReleasedDateLabel.textColor = .gray
            lastReleasedDateLabel.setContentHuggingPriority(
                .required,
                for: .horizontal
            )

            contentStackView.addArrangedSubview(lastReleasedDateLabel)
        }

        expandableTextView.configure(text: appItem.releaseNotes)
    }
}
