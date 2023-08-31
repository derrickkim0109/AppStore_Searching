//
//  AppSearchView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/22.
//

import UIKit

final class AppSearchView: BaseView {
    typealias DataSource = UITableViewDiffableDataSource<Section, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>

    enum Section {
        case main
    }

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RecentAppSearchTableViewCell.self)
        return tableView
    }()

    private lazy var dataSource = configureDataSource()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(tableView)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: topAnchor),
            tableView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 3),
            tableView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])
    }

    func applyDataSource(
        data: [String]
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

    private func configureDataSource() -> DataSource {
        return DataSource(
            tableView: tableView,
            cellProvider: {
                tableView,
                indexPath,
                item
                -> UITableViewCell? in
                let cell: RecentAppSearchTableViewCell = tableView.dequeueReusableCell(
                    forIndexPath: indexPath)
                cell.selectionStyle = .none

                cell.configure(
                    keyword: item,
                    isHiddenImage: true
                )
                return cell
            })
    }
}
