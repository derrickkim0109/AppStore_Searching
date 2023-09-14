//
//  AppSearchUseCase.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import Foundation

protocol AppSearchUseCaseInterface {
    func searchApp(
        by keyword: String,
        page : Int,
        size : Int
    ) async throws -> AppSearchEntity
    func getRecentKeywordList() -> [String]
}

final class AppSearchUseCase : AppSearchUseCaseInterface {
    private let searchRepository : AppSearchRepositoryInterface
    private let recentKeywordRepository : RecentKeywordRepositoryInterface

    init(
        searchRepository: AppSearchRepositoryInterface,
        recentKeywordRepository: RecentKeywordRepositoryInterface
    ) {
        self.searchRepository = searchRepository
        self.recentKeywordRepository = recentKeywordRepository
    }

    func searchApp(
        by keyword: String,
        page : Int,
        size : Int
    ) async throws -> AppSearchEntity {
        guard keyword.validateKeyword() else {
            throw AppSearchError.invalidKeyword
        }

        recentKeywordRepository.add(
            keyword: keyword
        )

        let offset = getOffset(
            page: page,
            size: size
        )

        do {
            let data = try await searchRepository.searchApp(
                by: keyword,
                page: offset,
                size: size
            )
            
            return data
        } catch {
            throw AppSearchError.failToSearchApp
        }
    }

    func getRecentKeywordList() -> [String] {
        return recentKeywordRepository.getRecentKeywordList()
    }

    private func getOffset(
        page: Int,
        size : Int
    ) -> Int {
        if page == 0 {
            return 0
        }

        return (page * size) + 1
    }
}
