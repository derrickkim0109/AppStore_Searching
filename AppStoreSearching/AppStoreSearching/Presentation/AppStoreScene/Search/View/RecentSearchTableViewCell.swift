//
//  RecentSearchTableViewCell.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/19.
//

import UIKit

final class RecentSearchTableViewCell: UITableViewCell {
    private let recentSearchingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .systemBlue
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
        addSubview(recentSearchingLabel)
    }
    
    private func configureLayouts() {
        NSLayoutConstraint.activate([
            recentSearchingLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor),
            recentSearchingLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 15),
            recentSearchingLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])
    }
    
    func configure(term: String) {
        recentSearchingLabel.text = term
    }
}

extension RecentSearchTableViewCell: ReusableView { }
