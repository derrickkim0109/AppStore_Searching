//
//  AppSearchInfoSummaryView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/02.
//

import UIKit

final class AppSearchInfoSummaryView: BaseView {
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                starRatingInfoStackView,
                developerInfoStackView,
                genreInfoStackView
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var starRatingInfoStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                starRatingView,
                userCountLabel
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 6
        return stackView
    }()
    
    private let starRatingView = StarRatingView()
    
    private let userCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(
            ofSize: 13
        )
        return label
    }()
    
    private lazy var developerInfoStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                developerIconImageView,
                developerNameLabel
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 6
        return stackView
    }()
    
    private let developerIconImageView: UIImageView = {
        let imageView = UIImageView(
            frame:
                CGRect(
                    x: 0,
                    y: 0,
                    width: 20,
                    height: 20
                )
        )
        
        imageView.tintColor = .lightGray
        imageView.image = UIImage(
            systemName: "person.crop.square"
        )
        imageView.setContentCompressionResistancePriority(
            .required,
            for: .horizontal
        )
        
        imageView.setContentHuggingPriority(
            .defaultHigh,
            for: .horizontal
        )
        return imageView
    }()
    
    private let developerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: 12,
            weight: .bold
        )
        
        label.setContentHuggingPriority(
            .defaultLow,
            for: .horizontal
        )
        return label
    }()
    
    private lazy var genreInfoStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                genreIconImageView,
                genreNameLabel
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 6
        return stackView
    }()
    
    private let genreIconImageView: UIImageView = {
        let imageView = UIImageView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 20,
                height: 20
            )
        )
        
        imageView.tintColor = .lightGray
        imageView.setContentCompressionResistancePriority(
            .required,
            for: .horizontal
        )
        
        imageView.setContentHuggingPriority(
            .defaultHigh,
            for: .horizontal
        )
        return imageView
    }()
    
    private let genreNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: 12,
            weight: .bold
        )
        label.setContentHuggingPriority(
            .defaultLow,
            for: .horizontal
        )
        return label
    }()
    
    override func setupDefault() {
        super.setupDefault()
    }
    
    override func addUIComponents() {
        super.addUIComponents()
        
        addSubview(rootStackView)
    }
    
    override func configureLayouts() {
        super.configureLayouts()
        
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(
                equalTo: topAnchor),
            rootStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            rootStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            rootStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            starRatingInfoStackView.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: 0.33),
            starRatingView.widthAnchor.constraint(
                equalTo: starRatingInfoStackView.widthAnchor,
                multiplier: 0.6),
            developerInfoStackView.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: 0.3),
            
            userCountLabel.centerYAnchor.constraint(
                equalTo: starRatingView.centerYAnchor)
        ])
    }
    
    func configure(_ appItem: AppSearchItemModel) {
        starRatingView.updatingViews(round(
            appItem.averageUserRating * 100) / 100)
        
        userCountLabel.text = appItem.userRatingCount.formattedNumber
        
        if userCountLabel.text == "0"
            || starRatingView.isHidden {
            starRatingInfoStackView.isHidden = true
        }
        
        developerNameLabel.text = appItem.artistName
        
        genreNameLabel.text = appItem.genres.first
        
        genreIconImageView.image = UIImage(
            systemName: appItem.getGenreImageName()
        )
    }
    
    func remove() {
        starRatingInfoStackView.isHidden = false
        userCountLabel.text = nil
        developerNameLabel.text = nil
        genreNameLabel.text = nil
    }
}
