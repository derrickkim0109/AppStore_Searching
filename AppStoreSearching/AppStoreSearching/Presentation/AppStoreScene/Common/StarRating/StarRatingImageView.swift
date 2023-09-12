//
//  StarRatingImageView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/06.
//

import UIKit

final class StarRatingImageView: UIView {
    private enum imageType {
        case fill
        case empty
    }

    private let filledImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .left
        imageView.clipsToBounds = true
        return imageView
    }()

    private let emptiedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .right
        imageView.clipsToBounds = true
        return imageView
    }()

    private let defaultImageWidth: CGFloat = 20
    private let defaultImageHeight: CGFloat = 20

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupDefault()
        addUIComponents()
        update(0.0)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func update(_ rating: Double) {
        let imageWidth = filledImageView.image?.size.width ?? 0
        let imageHeight = filledImageView.image?.size.height ?? 0
        let optimizedRating = min(5, max(rating, 0))
        let fillRatio = CGFloat(optimizedRating) / 1
        let emptyRatio = 1 - fillRatio

        filledImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: imageWidth * fillRatio,
            height: imageHeight
        )

        emptiedImageView.frame = CGRect(
            x: imageWidth * fillRatio,
            y: 0,
            width: imageWidth * emptyRatio,
            height: imageHeight
        )
    }

    private func setupDefault() {
        filledImageView.image = resize(image: .fill)
        emptiedImageView.image = resize(image: .empty)
    }

    private func addUIComponents() {
        [filledImageView,
         emptiedImageView]
            .forEach { addSubview($0) }
    }

    private func resize(
        image: imageType
    ) -> UIImage? {
        let widthRatio = frame.width / defaultImageWidth
        let heightRatio = frame.height / defaultImageHeight
        let ratio = min(widthRatio, heightRatio)

        let newWidth = defaultImageWidth * ratio
        let newHeight = defaultImageHeight * ratio

        let imageName = image == .fill ? "star.fill" : "star"

        guard let originalImage = UIImage(systemName: imageName)?.withTintColor(.lightGray) else {
            return nil
        }

        UIGraphicsBeginImageContextWithOptions(
            CGSize(
                width: newWidth,
                height: newHeight
            ),
            false,
            0
        )

        originalImage.draw(
            in: CGRect(
                x: 0,
                y: 0,
                width: newWidth,
                height: newHeight
            )
        )

        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }

        UIGraphicsEndImageContext()

        return resizedImage
    }
}
