//
//  RoundedButtonView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

import UIKit

final class RoundedButtonView: BaseView {
    private let roundedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(roundedButton)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            roundedButton.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            roundedButton.centerYAnchor.constraint(
                equalTo: centerYAnchor),

            roundedButton.widthAnchor.constraint(
                equalToConstant: 70),
            roundedButton.heightAnchor.constraint(
                equalToConstant: 30)
        ])
    }

    func configure(
        title: String,
        backgroundColor: UIColor?,
        fontSize: CGFloat,
        cornerRadius: CGFloat
    ) {
        roundedButton.setTitle(
            title,
            for: .normal
        )

        roundedButton.backgroundColor = backgroundColor

        roundedButton.titleLabel?.font = UIFont.systemFont(
            ofSize: fontSize,
            weight: .bold
        )

        roundedButton.setTitleColor(
            UIColor.systemBlue,
            for: .normal
        )
        roundedButton.layer.cornerRadius = cornerRadius
    }
}
