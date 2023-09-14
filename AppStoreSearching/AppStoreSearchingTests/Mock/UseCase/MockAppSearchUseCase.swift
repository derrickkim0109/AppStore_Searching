//
//  MockAppSearchUseCase.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/14.
//

@testable import AppStoreSearching

final class MockAppSearchUseCase: AppSearchUseCaseInterface {
    var scenario: Scenario = .success
    var appSearchEntity: AppSearchEntity = AppSearchEntityObjectMother.getAppSearchEntityWithCompleteData()
    var recentKeywordList: [String] = RecentKeywordObjectMother.getRecentKeywordList()

    func searchApp(
        by keyword: String,
        page: Int,
        size: Int
    ) async throws -> AppStoreSearching.AppSearchEntity {
        switch scenario {
        case .success: return appSearchEntity
        case .failure: throw AppSearchError.failToSearchApp
        }
    }

    func getRecentKeywordList() -> [String] {
        switch scenario {
        case .success:
            return recentKeywordList
        case .failure:
            return []
        }
    }
}
