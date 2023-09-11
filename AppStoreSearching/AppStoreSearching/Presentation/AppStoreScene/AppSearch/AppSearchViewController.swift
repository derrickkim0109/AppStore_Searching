//
//  AppSearchViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit
import Combine

protocol AppSearchViewControllerDelegate: AnyObject {
    func showDetailViewController(
        at viewController: UIViewController,
        of item: AppSearchItemModel
    )
}

final class AppSearchViewController: BaseViewController<AppSearchViewModel> {
    weak var coordinator: AppSearchViewControllerDelegate?
    
    private let appSearchView = AppSearchView()
    
    private var searchController: UISearchController?
    private let searchResultContainerViewController: SearchResultContainerViewController
    
    init(
        viewModel: AppSearchViewModel,
        searchResultContainerViewController: SearchResultContainerViewController
    ) {
        self.searchResultContainerViewController = searchResultContainerViewController
        
        super.init(viewModel: viewModel)
    }
    
    required init(viewModel: T) {
        fatalError()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func setupDefault() {
        super.setupDefault()
        
        view.backgroundColor = .systemBackground
        appSearchView.tableView.delegate = self
        setSearchController()
    }
    
    override func addUIComponents() {
        super.addUIComponents()
        
        view.addSubview(appSearchView)
    }
    
    override func bind() {
        super.bind()
        
        viewModel.$keyword
            .receive(on: DispatchQueue.main)
            .sink { [weak self] keyword in
                guard let `self` = self else {
                    return
                }
                
                viewModel.getRecentKeywordList()
                viewModel.resetProperties()

                switch viewModel.resultState {
                case .hasResult:
                    viewModel.searchApp(by: keyword)
                    
                    setupPostSearchBar(text: keyword)
                    
                    searchResultContainerViewController.handle(
                        keyword: keyword,
                        resultState: .hasResult
                    )
                    
                case .searching:
                    viewModel.filteredRecentKeywords = viewModel.filterRecentKeywords(
                        by: keyword
                    )
                    
                    searchResultContainerViewController.handle(
                        keyword: keyword,
                        resultState: .searching
                    )
                    
                case .none, .noResult:
                    break
                }
            }
            .store(in: &cancellable)
        
        viewModel.$recentKeywordList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] recentKeywordList in
                self?.appSearchView.applyDataSource(
                    data: recentKeywordList
                )
            }
            .store(in: &cancellable)

        viewModel.showDetailViewController
            .receive(on: DispatchQueue.main)
            .sink { [weak self] showDetailViewController in
                guard let `self` = self else {
                    return
                }

                if showDetailViewController == true {
                    coordinator?.showDetailViewController(
                        at: self,
                        of: viewModel.searchedAppList[viewModel.selectedIndex])
                }
            }
            .store(in: &cancellable)
    }
    
    override func configureLayouts() {
        super.configureLayouts()
        
        NSLayoutConstraint.activate([
            appSearchView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            appSearchView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            appSearchView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            appSearchView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setSearchController() {
        searchController = UISearchController(
            searchResultsController: searchResultContainerViewController)
        searchController?.searchBar.delegate = self
        searchController?.searchBar.placeholder = Const.placeHolder
        searchController?.searchBar.setValue(
            Const.cancel,
            forKey: Const.cancelKey
        )
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func setupPostSearchBar(
        text: String
    ) {
        searchController?.searchBar.text = text
        searchController?.isActive = true
        searchController?.searchBar.resignFirstResponder()
    }
    
    private func search(
        _ keyword: String,
        _ state: ResultState
    ) {
        viewModel.resultState = state
        viewModel.keyword = keyword
    }
    
    private enum Const {
        static let zero: CGFloat = 0
        static let fifteen = 15.0
        static let twentythree = 23.0
        static let placeHolder = "게임, 앱, 스토리 등"
        static let cancel = "취소"
        static let cancelKey = "cancelButtonText"
        static let recentTerm = "최근 검색어"
    }
}

extension AppSearchViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        search(
            searchText,
            .searching
        )
    }
    
    func searchBarCancelButtonClicked(
        _ searchBar: UISearchBar
    ) {
        viewModel.getRecentKeywordList()
    }
    
    func searchBarSearchButtonClicked(
        _ searchBar: UISearchBar
    ) {
        guard let searchText = searchBar.text else {
            return
        }
        
        search(
            searchText,
            .hasResult
        )
    }
}

extension AppSearchViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let keyword = viewModel.recentKeywordList[indexPath.row]
        
        tableView.deselectRow(
            at: indexPath,
            animated: false
        )
        
        viewModel.resultState = .hasResult
        viewModel.keyword = keyword
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return makeTableViewHeaderView(
            width: tableView.frame.width,
            height: 60.0
        )
    }
    
    private func makeTableViewHeaderView(
        width: CGFloat,
        height: CGFloat
    ) -> UIView {
        let headerView = UIView(
            frame: CGRect(
                x: Const.zero,
                y: Const.zero,
                width: width,
                height: height))
        headerView.backgroundColor = .systemBackground
        
        let label = UILabel(
            frame: CGRect(
                x: Const.fifteen,
                y: Const.zero,
                width: headerView.frame.width,
                height: headerView.frame.height
            )
        )
        
        label.text = Const.recentTerm
        label.textColor = UIColor.baseTextColor
        label.textAlignment = .left
        label.backgroundColor = .systemBackground
        label.font = UIFont.boldSystemFont(
            ofSize: Const.twentythree
        )
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(
                equalTo: headerView.centerYAnchor)
        ])
        return headerView
    }
}
