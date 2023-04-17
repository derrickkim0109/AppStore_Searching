//
//  SuggestedTermTableViewCell.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class SuggestedTermTableViewCell: UITableViewCell {
    private let suggestedIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Const.searchTermIcon)
        return imageView
    }()

    private let suggestedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?) {
            super.init(
                style: style,
                reuseIdentifier: reuseIdentifier)
            
            bind()
        }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func bind() {
        setupViews()
        configureLayouts()
    }

    private func setupViews() {
        [suggestedIconImageView,
         suggestedLabel].forEach{ addSubview($0) }
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            suggestedIconImageView.widthAnchor.constraint(
                equalTo: suggestedIconImageView.heightAnchor),
            suggestedIconImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Const.fifty),
            suggestedIconImageView.trailingAnchor.constraint(
                equalTo: suggestedLabel.leadingAnchor,
                constant: -Const.ten),
            suggestedIconImageView.heightAnchor.constraint(
                equalToConstant: Const.fifty),
            suggestedIconImageView.centerYAnchor.constraint(
                equalTo: centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            suggestedLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            suggestedLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor)
        ])
    }

    func configure(term: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: Const.sixty)]

        let attributedString = NSAttributedString(
            string: term.lowercased(),
            attributes: attributes)
        let mutableAttributedString = NSMutableAttributedString(
            attributedString: attributedString)

        suggestedLabel.attributedText = mutableAttributedString
    }

    private enum Const {
        static let ten = 10.0
        static let fifty = 15.0
        static let sixty = 16.0
        static let searchTermIcon = "searchTermIcon"
    }
}

extension SuggestedTermTableViewCell: ReusableView { }
