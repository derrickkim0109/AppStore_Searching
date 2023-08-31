//
//  AppSearchResultListViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

protocol AppSearchResultListViewControllerDelegate: AnyObject {
    func showDetailViewController(
        at viewController: UIViewController,
        of item: AppSearchItemModel)
}

final class AppSearchResultListViewController: BaseViewController<AppSearchViewModel> {
    private let appSearchResultListView = AppSearchResultListView()
    weak var coordinator: AppSearchResultListViewControllerDelegate?

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
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] item in
                self?.appSearchResultListView.applyDataSource(
                    data: item
                )
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
        
        coordinator?.showDetailViewController(
            at: self,
            of: viewModel.searchedAppList[indexPath.row])
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let visibleHeight = scrollView.frame.size.height

        if offsetY > contentHeight - visibleHeight {
            DispatchQueue.global().async { [weak self] in
                self?.viewModel.loadMoreData()
            }
        }
    }
}
