//
//  ExpandableLabelView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/09.
//

import UIKit

final class ExpandableLabelView: BaseView {
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                contentLabel,
                bottomUnderlineView
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        return stackView
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()

    private let seeMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.preferredFont(
            forTextStyle: .caption1
        )

        button.setTitle(
            "더 보기",
            for: .normal
        )

        button.setTitleColor(
            .systemBlue,
            for:.normal
        )
        return button
    }()

    private lazy var bottomUnderlineView = makeDiverView(
        type: .horizontal
    )

    private var isExpanded : Bool = false {
        didSet {
            seeMoreButton.isHidden = isExpanded

            if isExpanded {
                contentLabel.numberOfLines = 0
            }
        }
    }

    override func setupDefault() {
        super.setupDefault()

        seeMoreButton.addTarget(
            self,
            action:#selector(handleSeeMoreButton),
            for:.touchUpInside
        )
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(rootStackView)
        addSubview(seeMoreButton)
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
            bottomUnderlineView.widthAnchor.constraint(
                equalTo: rootStackView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            seeMoreButton.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -15),
            seeMoreButton.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            seeMoreButton.widthAnchor.constraint(
                equalToConstant: 35),
            seeMoreButton.heightAnchor.constraint(
                equalToConstant: 15)
        ])
    }

    func configure(text: String) {
        contentLabel.text = text
    }

    @objc private func handleSeeMoreButton() {
        self.isExpanded = true
    }
}
