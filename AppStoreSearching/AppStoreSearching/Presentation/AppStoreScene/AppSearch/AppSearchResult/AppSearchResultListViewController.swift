//
//  AppSearchResultListViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class AppSearchResultListViewController: BaseViewController<AppSearchViewModel> {
    private let appSearchResultListView = AppSearchResultListView()

    override func setupDefault() {
        super.setupDefault()
        
        appSearchResultListView.tableView.delegate = self
    }
    
    override func addUIComponents() {
        super.addUIComponents()
        
        view.addSubview(appSearchResultListView)
    }
    
    override func configureLayouts() {
        super.configureLayouts()
        
        NSLayoutConstraint.activate([
            appSearchResultListView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            appSearchResultListView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            appSearchResultListView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            appSearchResultListView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    override func bind() {
        super.bind()
        
        viewModel.$searchedAppList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
                self?.appSearchResultListView.applyDataSource(
                    data: item
                )
            }
            .store(in: &cancellable)
        
        viewModel.$showErrorAlert
            .receive(on: DispatchQueue.main)
            .sink { [weak self] showErrorAlert in
                if showErrorAlert
                    && self?.viewModel.searchedAppList.isEmpty == true {
                    AlertControllerBulider.Builder()
                        .setMessag(self?.viewModel.viewModelError?.rawValue ?? "")
                        .setConfrimText("확인")
                        .build()
                        .present()
                }
            }
            .store(in: &cancellable)
        
        viewModel.$resultState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] resultState in
                guard let state = self?.viewModel.resultState else {
                    return
                }
                
                switch state {
                case .noResult:
                    if self?.viewModel.searchedAppList.isEmpty == true {
                        self?.appSearchResultListView.setupError(
                            self?.viewModel.keyword ?? ""
                        )
                    }
                default:
                    self?.appSearchResultListView.hasWarningLabel(true)
                }
            }
            .store(in: &cancellable)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if self?.viewModel.isInitialLoading == true {
                    self?.appSearchResultListView.runLoadingIndicator(isLoading)
                }
            }
            .store(in: &cancellable)
    }
}

extension AppSearchResultListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 360.0
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(
            at: indexPath,
            animated: false)

        viewModel.selectedIndex = indexPath.row
        viewModel.showDetailViewController.send(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let visibleHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - visibleHeight - 100 {
            DispatchQueue.global().async { [weak self] in
                self?.viewModel.loadMoreData()
            }
        }
    }
}
