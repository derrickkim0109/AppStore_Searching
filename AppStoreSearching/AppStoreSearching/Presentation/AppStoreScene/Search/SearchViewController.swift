//
//  SearchViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class SearchViewController: UIViewController {
    private let viewModel: SearchViewModel
    private var searchType: SearchType = .final
    private var didSelect: (String) -> Void = { _ in }
    private let bag = AnyCancelTaskBag()

    private let recentTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RecentSearchTableViewCell.self)
        return tableView
    }()

    private var searchController: UISearchController?
    private let searchResultContainerViewController: SearchResultContainerViewController

    init(
        viewModel: SearchViewModel,
        searchResultContainerViewController: SearchResultContainerViewController) {
            self.viewModel = viewModel
            self.searchResultContainerViewController = searchResultContainerViewController

            super.init(
                nibName: nil,
                bundle: nil)
        }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
        setupViews()
        setSearchController()
        configureLayouts()
        didSelect = search
        viewModel.viewDidLoad()
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        extendedLayoutIncludesOpaqueBars = true

        recentTableView.delegate = self
        recentTableView.dataSource = self

        view.addSubview(recentTableView)
    }

    private func setSearchController() {
        searchController = UISearchController(
            searchResultsController: searchResultContainerViewController)
        searchController?.searchBar.delegate = self
        searchController?.searchBar.placeholder = Const.placeHolder
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.setValue(
            Const.cancel,
            forKey: Const.cancelKey)

        searchResultContainerViewController.didSelect = search

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            recentTableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            recentTableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            recentTableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recentTableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func search(term: String) {
        searchController?.searchBar.text = term
        searchType = .final
        searchController?.isActive = true
        searchController?.searchBar.resignFirstResponder()
        navigationController?.navigationBar.setShadow(hidden: false)
    }

    private enum Const {
        static let zero: CGFloat = 0
        static let one = 1
        static let fifteen = 15.0
        static let twentythree = 23.0
        static let fifty: CGFloat = 50.0
        static let title = "검색"
        static let recentTerm = "최근 검색어"
        static let placeHolder = "게임, 앱, 스토리 등"
        static let cancel = "취소"
        static let cancelKey = "cancelButtonText"
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Const.one
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return viewModel.recentKeywords.count
        }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: RecentSearchTableViewCell = tableView.dequeueReusableCell(
                forIndexPath: indexPath)

            cell.configure(term: viewModel.recentKeywords[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(
                at: indexPath,
                animated: false)

            didSelect(viewModel.recentKeywords[indexPath.row])
        }

    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int) -> UIView? {
            guard !viewModel.recentKeywords.isEmpty else {
                return nil
            }

            let headerView = UIView(
                frame: CGRect(
                    x: Const.zero,
                    y: Const.zero,
                    width: tableView.frame.width,
                    height: Const.fifty))
            headerView.backgroundColor = .systemBackground
            
            let label = UILabel(
                frame: CGRect(
                    x: Const.fifteen,
                    y: Const.zero,
                    width: headerView.frame.width,
                    height: headerView.frame.height))

            label.text = Const.recentTerm
            label.font = UIFont.boldSystemFont(ofSize: Const.twentythree)
            label.textColor = UIColor.baseTextColor
            label.textAlignment = .left
            label.backgroundColor = .systemBackground

            headerView.addSubview(label)

            return headerView
        }

    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat {
            return Const.fifty
        }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String) {
            searchType = searchText.isEmpty ? .final : .partial

            navigationController?.navigationBar.setShadow(hidden: searchText.isEmpty)
        }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.navigationBar.setShadow(hidden: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }

        search(term: text)
        updateSearchHistory(term: text)
    }

    func updateSearchHistory(term: String) {
        viewModel.save(term)
        recentTableView.reloadData()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
              !text.isEmpty else {
            return
        }

        searchResultContainerViewController.handle(
            term: text,
            searchType: searchType)
    }
}
