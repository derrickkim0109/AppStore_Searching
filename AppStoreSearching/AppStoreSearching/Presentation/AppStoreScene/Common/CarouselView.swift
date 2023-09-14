//
//  CarouselView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/11.
//

import UIKit

final class CarouselView: BaseView {
    typealias DataSource = UICollectionViewDiffableDataSource<CoverType, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CoverType, String>

    private lazy var carouselCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewFlowLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.isPagingEnabled = false // <- 한 페이지의 넓이를 조절 할 수 없기 때문에 scrollViewWillEndDragging을 사용하여 구현
        collectionView.contentInsetAdjustmentBehavior = .never // <- 내부적으로 safe area에 의해 가려지는 것을 방지하기 위해서 자동으로 inset조정해 주는 것을 비활성화
        collectionView.decelerationRate = .fast // <- 스크롤이 빠르게 되도록 (페이징 애니메이션같이 보이게하기 위함)
        collectionView.register(AppDetailCarouselCollectionViewCell.self)
        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 15,
            bottom: 0,
            right: 15
        )
        return collectionView
    }()

    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = itemSize
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    private lazy var dataSource = configureIPhoneDataSource()
    private let itemSize: CGSize
    private let itemSpacing: CGFloat
    private let type: CoverType

    init(
        itemSize: CGSize,
        itemSpacing: CGFloat,
        type: CoverType
    ) {
        self.itemSize = itemSize
        self.itemSpacing = itemSpacing
        self.type = type
        super.init()
    }

    required init() {
        fatalError()
    }

    override func setupDefault() {
        super.setupDefault()

        carouselCollectionView.delegate = self
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(carouselCollectionView)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            carouselCollectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            carouselCollectionView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            carouselCollectionView.heightAnchor.constraint(
                equalToConstant: itemSize.height),
            carouselCollectionView.centerYAnchor.constraint(
                equalTo: centerYAnchor)
        ])
    }

    func applyDataSource(
        type: CoverType,
        data: [String]
    ) {
        var snapshot = Snapshot()
        snapshot.appendSections([type])

        snapshot.appendItems(data)

        dataSource.apply(
            snapshot,
            animatingDifferences: false,
            completion: nil
        )
    }

    private func configureIPhoneDataSource() -> DataSource {
        let cellRegistration = UICollectionView.CellRegistration<AppDetailCarouselCollectionViewCell, String> {
            [weak self] (
                cell,
                indexPath,
                item
            ) in
            guard let type = self?.type else {
                return
            }

            var cornerRadius: CGFloat = 0.0
            switch type {
            case .iPhone: cornerRadius = 18
            case .iPad:   cornerRadius = 10
            }
            
            cell.configure(
                item,
                cornerRadius: cornerRadius
            )
        }

        return UICollectionViewDiffableDataSource<CoverType, String>(
            collectionView: carouselCollectionView
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

extension CarouselView: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = itemSize.width + itemSpacing
        let index = round(scrolledOffsetX / cellWidth)

        targetContentOffset.pointee = CGPoint(
            x: index * cellWidth - scrollView.contentInset.left - 50,
            y: scrollView.contentInset.top
        )
    }
}
