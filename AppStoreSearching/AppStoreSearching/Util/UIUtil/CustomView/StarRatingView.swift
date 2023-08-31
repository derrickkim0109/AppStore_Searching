//
//  StarRatingView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/19.
//

import UIKit

final class StarRatingView: BaseView {
    private let maxRating: Double = Const.five
    private var starViews: [UIImageView] = []

    private var ratingColor: UIColor = UIColor.gray {
        didSet {
            setNeedsLayout()
        }
    }

    var rating: Double = Const.zero {
        didSet {
            setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        removeAll()
        updateStars()
    }

    override func setupDefault() {
        super.setupDefault()

        backgroundColor = .clear
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            widthAnchor.constraint(
                equalToConstant: Const.seventy),
        ])
    }

    private func updateStars() {
        let starWidth = frame.size.width / CGFloat(maxRating)
        var spacing: CGFloat = Const.zero

        for i in 0..<Int(maxRating) {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: Const.star)

            imageView.frame = CGRect(
                x: (CGFloat(i) * starWidth) + spacing,
                y: (frame.size.height - Const.thirteen) / Const.two,
                width: Const.thirteen,
                height: Const.thirteen)

            imageView.tintColor = UIColor.gray
            addSubview(imageView)
            starViews.append(imageView)
            spacing += 0.2
        }

        let fullStarCount = Int(rating)
        let remainder = rating - Double(fullStarCount)

        for i in 0..<fullStarCount {
            starViews[i].image = UIImage(systemName: Const.starFill)
            starViews[i].tintColor = ratingColor
        }

        if remainder >= 0.1 && remainder <= 0.4 {
            starViews[fullStarCount].image = UIImage(systemName: Const.starLeadingHalf)
            starViews[fullStarCount].tintColor = ratingColor
        } else if remainder >= 0.5 && remainder <= 0.9 {
            starViews[fullStarCount].image = UIImage(systemName: Const.starFill)
            starViews[fullStarCount].tintColor = ratingColor
        } else if remainder >= 0.6 && remainder <= 0.9 {
            starViews[fullStarCount].image = UIImage(systemName: Const.starLeadingHalf)
            starViews[fullStarCount].tintColor = ratingColor
        } else {
            starViews[fullStarCount].image = UIImage(systemName: Const.star)
            starViews[fullStarCount].tintColor = UIColor.gray
        }
    }

    private func removeAll() {
        for view in starViews {
            view.removeFromSuperview()
        }

        starViews.removeAll()
    }

    private enum Const {
        static let zero = 0.0
        static let two = 2.0
        static let five = 5.0
        static let thirteen = 13.0
        static let seventy = 70.0
        static let star = "star"
        static let starFill = "star.fill"
        static let starLeadingHalf = "star.leadinghalf.fill"
    }
}
