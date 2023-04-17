//
//  FetchButton.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

import UIKit

final class FetchButton: UIButton {
    init() {
        super.init(frame: .zero)
        setupButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.fetchButtonBackgroundColor
        layer.cornerRadius = Const.fifteen
        setTitle(
            Const.fetch,
            for: .normal)
        titleLabel?.font = UIFont.systemFont(
            ofSize: Const.fifteen,
            weight: .bold)
        setTitleColor(
            UIColor.systemBlue,
            for: .normal)
        
        configureLayouts()
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(
                equalToConstant: Const.seventy),
            heightAnchor.constraint(
                equalToConstant: Const.thirty)
        ])
    }

    private enum Const {
        static let fifteen = 15.0
        static let thirty = 30.0
        static let seventy = 75.0
        static let fetch = "받기"
    }
}
