//
//  AppDetailInfoView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/07.
//

import UIKit

final class AppDetailInfoView: BaseView {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, AppInfoModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AppInfoModel>

    enum Section {
        case main
    }

    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                makeTitleLabelView("정보"),
                appDetailInfoCollectionView
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()

    private lazy var appDetailInfoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]

        collectionView.register(AppDetailInfoCollectionViewCell.self)
        return collectionView
    }()

    private lazy var dataSource = configureDataSource()

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
    }

    func configure(appItem: AppSearchItemModel) {
        let items: [AppInfoModel] = appItem.toAppInfoModel()

        applyDataSource(data: items)
    }

    private func applyDataSource(
        data: [AppInfoModel]
    ) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])

        snapshot.appendItems(data)

        dataSource.apply(
            snapshot,
            animatingDifferences: false,
            completion: nil
        )
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitems: [item]
        )

        let section = NSCollectionLayoutSection(
            group: group
        )

        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 10,
            bottom: 0,
            trailing: 10
        )

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func configureDataSource() -> DataSource {
        let cellRegistration = UICollectionView.CellRegistration<AppDetailInfoCollectionViewCell, AppInfoModel> {
            (cell,
             indexPath,
             item) in
            cell.configure(appInfo: item)
        }

        return UICollectionViewDiffableDataSource<Section, AppInfoModel>(
            collectionView: appDetailInfoCollectionView
        ) {
            (collectionView,
             indexPath,
             itemIdentifier) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
    }
}
