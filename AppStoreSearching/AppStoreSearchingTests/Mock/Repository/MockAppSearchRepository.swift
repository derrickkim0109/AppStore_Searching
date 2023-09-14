//
//  MockAppSearchRepository.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/14.
//

@testable import AppStoreSearching

final class MockAppSearchRepository: AppSearchRepositoryInterface {
    var scenario: Scenario = .success
    var appSearchEntity: AppSearchEntity = AppSearchEntityObjectMother.getAppSearchEntityWithCompleteData()

    func searchApp(
        by keyword: String,
        page: Int,
        size: Int
    ) async throws -> AppStoreSearching.AppSearchEntity {
        switch scenario {
        case .success: return appSearchEntity
        case .failure: throw NetworkError.unknownError
        }
    }
}
