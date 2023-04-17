//
//  StarRatingView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/19.
//

import UIKit

final class StarRatingView: UIView {
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

    init() {
        super.init(frame: .zero)
        configureLayouts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateStars()
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(
                equalToConstant: Const.seventy),
        ])
    }

    private func updateStars() {
        let starWidth = frame.size.width / CGFloat(maxRating)
        var spacing: CGFloat = Const.zero

        for view in starViews {
            view.removeFromSuperview()
        }
        starViews.removeAll()

        for i in 0..<Int(maxRating) {
            let imageView = UIImageView()
            imageView.image = UIImage(
                systemName: Const.star)

            imageView.frame = CGRect(
                x: (CGFloat(i) * starWidth) + spacing,
                y: (frame.size.height - Const.thirteen) / Const.two,
                width: Const.thirteen,
                height: Const.thirteen)

            imageView.tintColor = UIColor.gray
            addSubview(imageView)
            starViews.append(imageView)
            spacing += 1
        }

        let fullStarCount = Int(rating)

        for i in 0..<fullStarCount {
            starViews[i].image = UIImage(
                systemName: Const.starFill)
            starViews[i].tintColor = ratingColor
        }

        let remainder = rating - Double(fullStarCount)
        if remainder > Const.zero {
            starViews[fullStarCount].image = UIImage(
                systemName: Const.starLeadingHalf)
            starViews[fullStarCount].tintColor = ratingColor
        } else {
            guard fullStarCount != 0 else {
                 return
            }

            starViews[fullStarCount - 1].image = UIImage(
                systemName: Const.star)
            starViews[fullStarCount - 1].tintColor = UIColor.gray
        }
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
