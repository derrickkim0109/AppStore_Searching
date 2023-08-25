//
//  AppDetailScreenshotCollectionViewCell.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

import UIKit

final class AppDetailScreenshotCollectionViewCell: UICollectionViewCell {
    private let bag = AnyCancelTaskBag()
    
    private lazy var screenshotImageView: ScreenshotImageView = {
        var imageView = ScreenshotImageView()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func bind() {
        addSubview(screenshotImageView)
        configureLayouts()
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            screenshotImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor),
            screenshotImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor),
            screenshotImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            screenshotImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),
            screenshotImageView.heightAnchor.constraint(
                equalToConstant: Const.fiveHundredFifty),
            screenshotImageView.widthAnchor.constraint(
                equalToConstant: Const.twoHundredFifty),
        ])
    }

    func configure(_ screenUrl: String) {
        Task { [weak self] in
            guard let `self` = self else {
                return
            }


        }.store(in: bag)
    }

    private enum Const {
        static let fiveHundredFifty = 550.0
        static let twoHundredFifty = 250.0
        static let confirm = "확인"
    }
}

extension AppDetailScreenshotCollectionViewCell: ReusableView { }
