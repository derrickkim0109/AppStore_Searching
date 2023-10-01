//
//  AppSearchDependencyContainer.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/10/01.
//

protocol AppSearchDependencyContainerDelegate {
    func makeAppSearchViewController() -> AppSearchViewController
}

final class AppSearchDependencyContainer: AppSearchDependencyContainerDelegate {
    init() { }

    func makeAppSearchViewController() -> AppSearchViewController {
        let viewModel = appSearchDependencies()
        return AppSearchViewController(
            viewModel: viewModel,
            searchResultContainerViewController: searchResultContainerViewController(viewModel: viewModel)
        )
    }

    private func appSearchDependencies() -> AppSearchViewModel {
        let networkService: NetworkService = NetworkService()
        let dataSource : AppSearchDataSourceInterface = AppSearchDataSource(
            networkService: networkService
        )
        let repository : AppSearchRepositoryInterface = AppSearchRepository(
            dataSource: dataSource
        )
        let useCase : AppSearchUseCaseInterface = AppSearchUseCase(
            searchRepository: repository,
            recentKeywordRepository: getRecentKeywordDependencies()
        )
        let viewModel : AppSearchViewModel = AppSearchViewModel(
            appSearchUseCase: useCase
        )

        return viewModel
    }

    private func getRecentKeywordDependencies() -> RecentKeywordRepositoryInterface {
        let recentKeywordStorage: RecentKeywordStorageInterface = RecentKeywordStorage()
        let recentKeywordRepository: RecentKeywordRepositoryInterface = RecentKeywordRepository(
            recentKeywordStorage: recentKeywordStorage
        )

        return recentKeywordRepository
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
        return viewController
    }
}
