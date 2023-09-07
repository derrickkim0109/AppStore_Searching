//
//  RoundedButtonView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

import UIKit

final class RoundedButtonView: BaseView {
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(button)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            button.centerYAnchor.constraint(
                equalTo: centerYAnchor)
        ])
    }

    func configure(
        title: String,
        backgroundColor: UIColor?,
        fontSize: CGFloat,
        cornerRadius: CGFloat
    ) {
        button.setTitle(
            title,
            for: .normal
        )

        button.backgroundColor = backgroundColor

        button.titleLabel?.font = UIFont.systemFont(
            ofSize: fontSize,
            weight: .bold
        )

        button.setTitleColor(
            UIColor.systemBlue,
            for: .normal
        )
        button.layer.cornerRadius = cornerRadius
    }
}
