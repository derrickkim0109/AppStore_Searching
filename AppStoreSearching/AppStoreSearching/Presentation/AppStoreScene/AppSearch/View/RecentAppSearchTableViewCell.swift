//
//  RecentAppSearchTableViewCell.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class RecentAppSearchTableViewCell: UITableViewCell {
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchingIconImageView,
                                                      recentKeywordLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()

    private let searchingIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Const.searchIcon)
        return imageView
    }()

    private let recentKeywordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(
            ofSize: 20
        )
        return label
    }()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?) {
            super.init(
                style: style,
                reuseIdentifier: reuseIdentifier)
            
            setupDefault()
            configureLayouts()
        }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        recentKeywordLabel.text = nil
        searchingIconImageView.isHidden = true
    }

    private func setupDefault() {
        addSubview(rootStackView)
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
                equalTo: contentView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            searchingIconImageView.widthAnchor.constraint(
                equalTo: searchingIconImageView.heightAnchor),
            searchingIconImageView.heightAnchor.constraint(
                equalToConstant: Const.fifty)
        ])
    }

    func configure(
        keyword: String,
        isHiddenImage: Bool
    ) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(
                ofSize: Const.sixty
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
        searchingIconImageView.isHidden = isHiddenImage
    }

    private enum Const {
        static let ten = 10.0
        static let fifty = 15.0
        static let sixty = 16.0
        static let searchIcon = "magnifyingGlass"
    }
}

extension RecentAppSearchTableViewCell: ReusableView { }
