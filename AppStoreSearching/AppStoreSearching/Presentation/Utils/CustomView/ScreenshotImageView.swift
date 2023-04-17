//
//  ScreenshotImageView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

import UIKit

final class ScreenshotImageView: UIImageView {
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
        layer.cornerRadius = Const.twenty
        layer.borderWidth = Const.zeroPointFifteen
        layer.borderColor = UIColor.lightGray.cgColor
        clipsToBounds = true
        isOpaque = true
        clearsContextBeforeDrawing = true
    }

    private enum Const {
        static let zeroPointFifteen = 0.15
        static let twenty = 20.0
    }
}
