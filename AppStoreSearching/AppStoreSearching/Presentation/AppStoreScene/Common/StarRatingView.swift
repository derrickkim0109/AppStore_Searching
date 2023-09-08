//
//  StarRatingView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/19.
//

import UIKit

final class StarRatingView: BaseView {
    private let starImageViewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()
    
    private let maxRating: Int = 5
    
    override func setupDefault() {
        super.setupDefault()
    }
    
    override func addUIComponents() {
        super.addUIComponents()
        
        addSubview(starImageViewStackView)
        
        for _ in 0..<maxRating {
            starImageViewStackView.addArrangedSubview(makeStarRatingImageView(0.0))
        }
    }
    
    override func configureLayouts() {
        super.configureLayouts()
        
        NSLayoutConstraint.activate([
            starImageViewStackView.topAnchor.constraint(
                equalTo: topAnchor),
            starImageViewStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            starImageViewStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            starImageViewStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])
    }
    
    func updatingViews(_ rating: Double) {
        let filledStarsCount = Int(rating)
        let remainder = rating - Double(filledStarsCount)
        
        for (index, view) in starImageViewStackView.subviews.enumerated() {
            guard let ratingView = view as? StarRatingImageView else {
                return
            }
            
            if index < filledStarsCount {
                ratingView.update(1.0)
            } else if index == filledStarsCount && remainder > 0 {
                ratingView.update(remainder)
            } else {
                ratingView.update(0.0)
            }
        }
    }
}
