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

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    private lazy var warningLabelStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                warningLabel,
                keywordLabel
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private let warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "결과 없음"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()

    private let keywordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        return label
    }()

    private lazy var dataSource = configureDataSource()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        [tableView,
         activityIndicator,
         warningLabelStackView]
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
            warningLabelStackView.centerXAnchor.constraint(
                equalTo: tableView.centerXAnchor),
            warningLabelStackView.centerYAnchor.constraint(
                equalTo: tableView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(
                equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(
                equalTo: tableView.centerYAnchor)
        ])
    }

    func applyDataSource(
        data: [AppSearchItemModel]
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

    func setupError(_ keyword: String) {
        keywordLabel.text = keyword
        hasWarningLabel(false)
    }

    func hasWarningLabel(_ isHidden: Bool) {
        warningLabelStackView.isHidden = isHidden
    }

    func runLoadingIndicator(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
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
