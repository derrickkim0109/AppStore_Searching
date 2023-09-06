//
//  RecentKeywordListViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class RecentKeywordListViewController: BaseViewController<AppSearchViewModel> {
    typealias DataSource = UITableViewDiffableDataSource<Section, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>
    
    enum Section {
        case main
    }
    
    private let recentSearchKeywordTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RecentAppSearchTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView(
            frame: CGRect(
                x: Const.zero,
                y: Const.zero,
                width: tableView.bounds.size.width,
                height: CGFloat.leastNormalMagnitude
            )
        )
        return tableView
    }()
    
    private lazy var dataSource = configureDataSource()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        applyDataSource(
            data: viewModel.filteredRecentKeywords
        )
    }
    
    override func setupDefault() {
        super.setupDefault()
        
        recentSearchKeywordTableView.delegate = self
    }
    
    override func addUIComponents() {
        super.addUIComponents()
        
        view.addSubview(recentSearchKeywordTableView)
    }
    
    override func configureLayouts() {
        super.configureLayouts()
        
        NSLayoutConstraint.activate([
            recentSearchKeywordTableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 15),
            recentSearchKeywordTableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            recentSearchKeywordTableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recentSearchKeywordTableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func applyDataSource(
        data: [String]
    ) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        
        Task { [weak self] in
            await MainActor.run() {
                self?.dataSource.apply(
                    snapshot,
                    animatingDifferences: false,
                    completion: nil
                )
            }
        }.store(in: bag)
    }
    
    private func configureDataSource() -> DataSource {
        return DataSource(
            tableView: recentSearchKeywordTableView,
            cellProvider: {
                tableView,
                indexPath,
                item
                -> UITableViewCell? in
                let cell: RecentAppSearchTableViewCell = tableView.dequeueReusableCell(
                    forIndexPath: indexPath
                )
                cell.selectionStyle = .none
                cell.configure(
                    keyword: item,
                    isHiddenImage: false
                )
                return cell
            })
    }
    
    private enum Const {
        static let zero = 0.0
    }
}

extension RecentKeywordListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let item = dataSource.itemIdentifier(
            for: indexPath) else {
            return
        }
        
        tableView.deselectRow(
            at: indexPath,
            animated: false
        )
        
        viewModel.resultState = .hasResult
        viewModel.keyword = item
    }
}
