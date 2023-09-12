//
//  AppDetailCarouselCollectionViewCell.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/11.
//

import UIKit

final class AppDetailCarouselCollectionViewCell: UICollectionViewCell {
    private let screenshotImageView: CachedAsyncImageView = {
        let imageView = CachedAsyncImageView()
        imageView.setupBoarder(0.3)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addUIComponents()
        configureLayouts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func addUIComponents() {
        contentView.addSubview(screenshotImageView)
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
                equalTo: contentView.trailingAnchor)
        ])
    }
    override func prepareForReuse() {
        super.prepareForReuse()

        screenshotImageView.remove()
    }

    func configure(
        _ url: String,
        cornerRadius: CGFloat
    ) {
        let cachedIconImageInfo = CachedImageInfo(
            urlStr: url,
            cornerRadius: cornerRadius
        )

        screenshotImageView.configure(
            cachedIconImageInfo
        )
    }
}

extension AppDetailCarouselCollectionViewCell: ReusableView { }
