//
//  ExpandableLabelView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/09.
//

import UIKit

final class ExpandableLabelView: BaseView {
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()

    private let buttonContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let seeMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .right
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

    private var isExpanded : Bool = false {
        didSet {
            seeMoreButton.isHidden = isExpanded

            if isExpanded {
                contentLabel.numberOfLines = 0
            } else {
                contentLabel.numberOfLines = 3
            }
        }
    }

    private var heightAnchorConstraint : NSLayoutConstraint?

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

        [contentLabel,
         buttonContainerView]
            .forEach { addSubview($0) }

        buttonContainerView.addSubview(seeMoreButton)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(
                equalTo: topAnchor),
            contentLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            contentLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            buttonContainerView.topAnchor.constraint(
                equalTo: contentLabel.bottomAnchor),
            buttonContainerView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            buttonContainerView.trailingAnchor.constraint(
                equalTo: trailingAnchor),

            bottomAnchor.constraint(
                greaterThanOrEqualTo: buttonContainerView.bottomAnchor,
                constant: 8)
        ])

        NSLayoutConstraint.activate([
            seeMoreButton.topAnchor.constraint(
                equalTo: buttonContainerView.topAnchor),
            seeMoreButton.trailingAnchor.constraint(
                equalTo: buttonContainerView.trailingAnchor),
            seeMoreButton.bottomAnchor.constraint(
                equalTo: buttonContainerView.bottomAnchor)
        ])
    }

    func configure(text: String) {
        contentLabel.text = text
    }

    @objc func handleSeeMoreButton() {
        self.isExpanded.toggle()
    }
}
