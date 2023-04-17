//
//  IconImageView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

import UIKit

final class IconImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        setupImageView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupImageView() {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleToFill
        layer.cornerRadius = Const.twelve
        layer.borderWidth = Const.zeroPointFifteen
        layer.borderColor = UIColor.lightGray.cgColor
        clipsToBounds = true
        isOpaque = true
        clearsContextBeforeDrawing = true
        
        configureLayouts()
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(
                equalTo: heightAnchor),

        ])
    }

    private enum Const {
        static let zeroPointFifteen = 0.15
        static let twelve = 12.0
    }
}
