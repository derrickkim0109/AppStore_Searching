//
//  AppDetailInfoCollectionViewCell.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/13.
//

import UIKit

final class AppDetailInfoCollectionViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(
            ofSize: 13
        )
        label.textColor = .gray
        return label
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                infoLabel,
                accessoryImageView
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: 14,
            weight: .bold
        )
        return label
    }()

    private let accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = UIColor.lightGray
        return imageView
    }()

    private lazy var bottomUnderlineView = makeDiverView(
        type: .horizontal
    )

    override init(frame: CGRect) {
        super.init(frame: frame)

        addUIComponents()
        configureLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        configure(appInfo: nil)
    }

    private func addUIComponents() {
        [titleLabel,
         infoStackView,
         bottomUnderlineView]
            .forEach{ contentView.addSubview($0) }
    }

    private func configureLayouts() {
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: inset),
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: inset),
            titleLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -inset),
            titleLabel.trailingAnchor.constraint(
                equalTo: accessoryImageView.leadingAnchor,
                constant: -inset),
        ])

        NSLayoutConstraint.activate([
            accessoryImageView.widthAnchor.constraint(
                equalToConstant: 20),
            accessoryImageView.heightAnchor.constraint(
                equalToConstant: 20),
            infoStackView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor),
            infoStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -inset)
        ])

        NSLayoutConstraint.activate([
            bottomUnderlineView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: inset),
            bottomUnderlineView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor),
            bottomUnderlineView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -inset)
        ])
    }
}

extension AppDetailInfoCollectionViewCell {
    func configure(appInfo: AppInfoModel?) {
        titleLabel.text = appInfo?.type.rawValue

        accessoryImageView.isHidden = (appInfo?.type == .compatibility
                                       || appInfo?.type == .language) ? false : true
        let languageCount = appInfo?.info.count ?? 0
        let languageInfo = "\(appInfo?.info.first ?? "") 외 \(languageCount - 1)개"

        infoLabel.text = appInfo?.type == .language ? languageInfo : appInfo?.info.first
    }
}

extension AppDetailInfoCollectionViewCell: ReusableView { }
