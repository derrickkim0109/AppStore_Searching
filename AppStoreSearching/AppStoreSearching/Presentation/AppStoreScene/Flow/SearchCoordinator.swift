//
//  SearchCoordinator.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

import UIKit

protocol SearchCoordinatorDelegate: AnyObject { }

class SearchCoordinator: Coordinator,
                         AppSearchResultListViewControllerDelegate,
                         AppDetailViewControllerDelegate {
    weak var parentCoordinator: SearchCoordinatorDelegate?

    var childCoordinators = [Coordinator]()
    private var navigationController = UINavigationController()

    func start() -> UINavigationController {
        let searchViewController = setViewController()
        return setNavigationController(
            with: searchViewController
        )
    }

    func showDetailViewController(
        at viewController: UIViewController,
        of item: AppSearchItemModel) {
            let viewModel = AppDetailViewModel(appItem: item)
            let viewController = AppDetailViewController(viewModel: viewModel)

            navigationController.pushViewController(
                viewController,
                animated: true
            )
        }

    private func setViewController() -> UIViewController {
        let viewModel: AppSearchViewModel = appSearchDependencies()
        let viewController = AppSearchViewController(
            viewModel: viewModel,
            searchResultContainerViewController: searchResultContainerViewController(
                viewModel: viewModel
            )
        )

        return viewController
    }

    private func setNavigationController(
        with viewController: UIViewController
    ) -> UINavigationController {

        navigationController.pushViewController(
            viewController,
            animated: false
        )

        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.topItem?.title = "검색"

        return navigationController
    }

    private func getRecentKeywordDependencies() -> RecentKeywordRepositoryInterface {
        let recentKeywordStorage: RecentKeywordStorageInterface = RecentKeywordStorage()
        let recentKeywordRepository: RecentKeywordRepositoryInterface = RecentKeywordRepository(
            recentKeywordStorage: recentKeywordStorage
        )

        return recentKeywordRepository
    }

    func appSearchDependencies() -> AppSearchViewModel {
        let networkService: NetworkService = NetworkService()
        let dataSource : AppSearchDataSourceInterface = AppSearchDataSource(
            networkService: networkService)
        let repository : AppSearchRepositoryInterface = AppSearchRepository(
            dataSource: dataSource)
        let useCase : AppSearchUseCaseInterface = AppSearchUseCase(
            searchRepository: repository,
            recentKeywordRepository: getRecentKeywordDependencies())
        let viewModel : AppSearchViewModel = AppSearchViewModel(
            appSearchUseCase: useCase)

        return viewModel
    }

    private func searchResultContainerViewController(
        viewModel: AppSearchViewModel
    ) -> SearchResultContainerViewController {
        let viewController = SearchResultContainerViewController(
            recentKeywordListViewController: suggestedTermsTableViewController(
                viewModel: viewModel
            ),
            appsInfoListViewController: appsInfoListViewController(
                viewModel: viewModel
            )
        )
        return viewController
    }
    
    private func suggestedTermsTableViewController(
        viewModel: AppSearchViewModel
    ) -> RecentKeywordListViewController {
        let viewController = RecentKeywordListViewController(
            viewModel: viewModel
        )
        return viewController
    }

    private func appsInfoListViewController(
        viewModel: AppSearchViewModel
    ) -> AppSearchResultListViewController {
        let viewController = AppSearchResultListViewController(
            viewModel: viewModel
        )
        viewController.coordinator = self
        return viewController
    }
}
