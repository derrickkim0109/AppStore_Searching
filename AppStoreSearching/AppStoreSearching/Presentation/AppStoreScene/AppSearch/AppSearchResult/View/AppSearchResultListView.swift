//
//  AppSearchResultListView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/22.
//

import UIKit

final class AppSearchResultListView: BaseView {
    typealias DataSource = UITableViewDiffableDataSource<Section, AppSearchItemModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AppSearchItemModel>

    enum Section {
        case main
    }

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AppSearchResultListTableViewCell.self)
        tableView.separatorStyle = .none
        
        return tableView
    }()

    private let warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.textColor = .white
        label.font = UIFont.systemFont(
            ofSize: 16,
            weight: .medium
        )
        return label
    }()

    private lazy var dataSource = configureDataSource()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        [tableView,
         warningLabel]
            .forEach{ addSubview($0) }
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: topAnchor),
            tableView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            warningLabel.centerXAnchor.constraint(
                equalTo: tableView.centerXAnchor),
            warningLabel.centerYAnchor.constraint(
                equalTo: tableView.centerYAnchor)
        ])
    }

    func applyDataSource(
        data: [AppSearchItemModel]
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

    func setupErrorText(_ text: String) {
        warningLabel.text = text
        hasWarningLabel(false)
    }

    func hasWarningLabel(_ isHidden: Bool) {
        warningLabel.isHidden = isHidden
    }

    private func configureDataSource() -> DataSource {
        return DataSource(
            tableView: tableView,
            cellProvider: {
                tableView,
                indexPath,
                item
                -> UITableViewCell? in
                let cell: AppSearchResultListTableViewCell = tableView.dequeueReusableCell(
                    forIndexPath: indexPath
                )
                
                cell.selectionStyle = .none
                cell.configure(
                    appItem: item
                )

                return cell
            })
    }

    private enum Const {
        static let title = "알림"
        static let confirm = "확인"
        static let warning = "검색 결과가 없습니다."
        static let threeHundredSixty = 360.0
    }
}
