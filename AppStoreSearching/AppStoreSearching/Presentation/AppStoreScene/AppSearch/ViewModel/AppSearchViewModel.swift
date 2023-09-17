//
//  AppSearchViewModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/22.
//

import Foundation
import Combine

final class AppSearchViewModel {
    var keyword = CurrentValueSubject<String, Never>("")
    var searchedAppList = CurrentValueSubject<[AppSearchItemModel], Never>([])
    var recentKeywordList = CurrentValueSubject<[String], Never>([])
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var showErrorAlert = CurrentValueSubject<Bool, Never>(false)
    var resultState = CurrentValueSubject<ResultState, Never>(.none)

    var showDetailViewController = PassthroughSubject<Bool, Never>()

    var selectedIndex: Int = 0
    var viewModelError: AppSearchError?
    var isInitialLoading: Bool = false
    var filteredRecentKeywords: [String] = []

    var currentPage: Int = 0
    private let perPage: Int = 10
    private let appSearchUseCase: AppSearchUseCaseInterface
    private let bag = AnyCancelTaskBag()

    init(
        appSearchUseCase: AppSearchUseCaseInterface
    ) {
        self.appSearchUseCase = appSearchUseCase
    }

    func searchApp(
        by keyword : String
    ) {
        Task { [weak self] in
            self?.setLoadingState()
            self?.getRecentKeywordList()
            
            let appSearchEntity = try await self?.getAppSearchEntity(by: keyword)
            let appSearchModel = AppSearchModelMapper.toPresentationModel(entity: appSearchEntity)

            guard !appSearchModel.results.isEmpty else {
                self?.resultState.value = .noResult
                return
            }

            self?.resetLoadingState()

            self?.resultState.value = .hasResult

            let filterData = appSearchModel.results
                .filter{ [weak self] newItem in
                    self?.searchedAppList.value.contains { $0.artistId == newItem.artistId } == false
                }

            self?.searchedAppList.value.append(
                contentsOf: self?.searchedAppList.value.isEmpty == true ? appSearchModel.results : filterData
            )

            self?.currentPage += 10
        }.store(in: bag)
    }

    func getRecentKeywordList() {
        let repository = appSearchUseCase.getRecentKeywordList()
        recentKeywordList.value = repository.isEmpty ? [Const.recentKeywordEmpty] : repository
    }

    func filterRecentKeywords(
        by keyword: String
    ) -> [String] {
        guard !keyword.isEmpty else { return [] }

        let result = recentKeywordList.value.filter {
            return $0
                .lowercased()
                .contains(keyword.lowercased())
        }.sorted()

        guard result.count > 10 else {
            return result
        }

        return result
            .prefix(10)
            .map { $0 }
    }
    
    func resetProperties() {
        searchedAppList.value = []
        currentPage = 0
        viewModelError = nil
    }

    func loadMoreData() {
        searchApp(by: keyword.value)
    }

    private func getAppSearchEntity(
        by keyword: String
    ) async throws -> AppSearchEntity {
        do {
            let appSearchEntity = try await appSearchUseCase.searchApp(
                by: keyword,
                page: currentPage,
                size: perPage
            )

            return appSearchEntity
        } catch (let error) {
            setErrorProperties(error: error)
            throw error
        }
    }

    private func setErrorProperties(
        error: Error
    ) {
        guard let error = error as? AppSearchError else {
            return
        }

        resultState.value = .noResult
        showErrorAlert.value = true
        viewModelError = error
    }

    private func setLoadingState() {
        if currentPage == 0 {
            return isInitialLoading = true
        }

        isLoading.value = true
    }
    
    private func resetLoadingState() {
        isLoading.value = false
        isInitialLoading = false
    }

    private enum Const {
        static let recentKeywordEmpty = "최근 검색어가 없습니다."
    }
}
