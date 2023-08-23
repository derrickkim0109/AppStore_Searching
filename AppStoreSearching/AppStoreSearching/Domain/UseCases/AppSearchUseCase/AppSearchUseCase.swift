//
//  AppSearchUseCase.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import Foundation

protocol AppSearchUseCaseInterface {
    func searchAppByKeyword(
        keyword : String,
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

    func searchAppByKeyword(
        keyword : String,
        page : Int,
        size : Int
    ) async throws -> AppSearchEntity {
        guard keyword.validateKeyword() else {
            throw AppSearchError.invalidKeyword
        }

        recentKeywordRepository.addRecentKeyword(
            keyword: keyword
        )

        let offset = getOffset(
            page: page,
            size: size
        )

        do {
            let data = try await searchRepository.searchAppByKeyword(
                keyword: keyword,
                page: offset,
                size: size
            )
            
            return data
        } catch {
            // NetworkError -> AppSearchError로 맵핑
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
