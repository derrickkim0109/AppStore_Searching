//
//  RecentAppSearchTableViewCell.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class RecentAppSearchTableViewCell: UITableViewCell {
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [iconContainerView,
                               recentKeywordLabel]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var iconContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.addSubview(searchingIconImageView)
        return view
    }()
    
    private let searchingIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(
            systemName: Const.searchIcon
        )
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let recentKeywordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(
            ofSize: 20
        )
        return label
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        
        setupDefault()
        addUIComponents()
        configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        recentKeywordLabel.text = nil
    }
    
    private func setupDefault() {
        contentView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
    }
    
    private func addUIComponents() {
        contentView.addSubview(rootStackView)
    }
    
    private func configureLayouts() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor),
            rootStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor),
            rootStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 15),
            rootStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),
            
            rootStackView.heightAnchor.constraint(
                equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            iconContainerView.widthAnchor.constraint(
                equalTo: rootStackView.widthAnchor,
                multiplier: 0.05),
            searchingIconImageView.centerXAnchor.constraint(
                equalTo: iconContainerView.centerXAnchor),
            searchingIconImageView.centerYAnchor.constraint(
                equalTo: iconContainerView.centerYAnchor),
            
            searchingIconImageView.widthAnchor.constraint(
                equalTo: searchingIconImageView.heightAnchor),
            searchingIconImageView.heightAnchor.constraint(
                equalToConstant: 15)
        ])
    }
    
    func configure(
        keyword: String,
        isHiddenImage: Bool
    ) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(
                ofSize: Const.sixteen
            )
        ]
        
        let attributedString = NSAttributedString(
            string: keyword.lowercased(),
            attributes: attributes
        )
        
        let mutableAttributedString = NSMutableAttributedString(
            attributedString: attributedString
        )
        
        recentKeywordLabel.attributedText = mutableAttributedString
        iconContainerView.isHidden = isHiddenImage
    }
    
    private enum Const {
        static let ten = 10.0
        static let fifteen = 15.0
        static let sixteen = 16.0
        static let searchIcon = "magnifyingglass"
    }
}

extension RecentAppSearchTableViewCell: ReusableView { }
