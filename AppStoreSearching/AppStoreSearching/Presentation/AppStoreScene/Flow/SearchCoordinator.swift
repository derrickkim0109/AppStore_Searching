//
//  SearchCoordinator.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

import UIKit

protocol SearchCoordinatorDelegate: AnyObject { }

class SearchCoordinator: Coordinator,
                         AppsInfoListViewControllerDelegate,
                         AppDetailViewControllerDelegate {
    weak var parentCoordinator: SearchCoordinatorDelegate?
    
    var childCoordinators = [Coordinator]()
    private var navigationController = UINavigationController()
    private let apiDataTransferService: DataTransferService

    init(apiDataTransferService: DataTransferService) {
        self.apiDataTransferService = apiDataTransferService
    }

    func start() -> UINavigationController {
        let searchViewController = setViewController()
        return setNavigationController(with: searchViewController)
    }

    private func setViewController() -> UIViewController {
        let viewModel = DefaultSearchViewModel()
        let viewController = SearchViewController(
            viewModel: viewModel,
            searchResultContainerViewController: searchResultContainerViewController())
        return viewController
    }

    private func setNavigationController(
        with viewController: UIViewController) -> UINavigationController {
            navigationController.setViewControllers(
                [viewController],
                animated: false)

            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.topItem?.title = "검색"
            navigationController.navigationBar.setShadow(hidden: true)

            return navigationController
        }

    private func searchResultContainerViewController() -> SearchResultContainerViewController {
        let viewController = SearchResultContainerViewController(
            suggestedTermsTableViewController: suggestedTermsTableViewController(),
            appsInfoListViewController: appsInfoListViewController())
        return viewController
    }

    private func suggestedTermsTableViewController() -> SuggestedTermsTableViewController {
        let viewModel: SuggestedTermsTableViewModel = DefaultSuggestedTermsTableViewModel()
        let viewController = SuggestedTermsTableViewController(viewModel: viewModel)
        return viewController
    }

    private func appsInfoListViewController() -> AppsInfoListViewController {
        let appsInfoRepository: AppsInfoRepository = DefaultAppsInfoRepository(
            dataTransferService: apiDataTransferService)
        let searchAppsInfoUseCase: SearchAppsInfoUseCase = DefaultSearchAppsInfoUseCase(
            appsInfoRepository: appsInfoRepository)
        let viewModel: AppsInfoListViewModel = DefaultAppsInfoLisViewModel(
            searchAppsInfoUseCase: searchAppsInfoUseCase)
        let viewController = AppsInfoListViewController(viewModel: viewModel)
        viewController.coordinator = self
        return viewController
    }

    func showDetailViewController(
        at viewController: UIViewController,
        of id: Int) {
            let appInfoRepository: AppInfoRepository = DefaultAppInfoRepository(
                dataTransferService: apiDataTransferService)

            let fetchAppInfoUseCase: FetchAppInfoUseCase = DefaultFetchAppInfoUseCase(
                appInfoRepository: appInfoRepository)

            let viewModel = DefaultAppDetailViewModel(
                appId: id,
                fetchAppInfoUseCase: fetchAppInfoUseCase)

            let detailViewController = AppDetailViewController(viewModel: viewModel)
            detailViewController.coordinator = self
            navigationController.navigationBar.prefersLargeTitles = false
            navigationController.pushViewController(
                detailViewController,
                animated: true)
        }
}
