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
                buttonContainerView
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

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
            buttonContainerView.isHidden = isExpanded

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

        addSubview(rootStackView)
        buttonContainerView.addSubview(seeMoreButton)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(
                equalTo: topAnchor),
            rootStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            rootStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            bottomAnchor.constraint(
                greaterThanOrEqualTo: rootStackView.bottomAnchor,
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
