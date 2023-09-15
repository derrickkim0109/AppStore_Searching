//
//  MockAppSearchDataSource.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/15.
//

@testable import AppStoreSearching

final class MockAppSearchDataSource: AppSearchDataSourceInterface {
    var scenario: Scenario = .success

    var appSearchResponseDTO = AppSearchDTOObjectMother.getAppSearchResponseDTOWithCompleteData()
    var networkError = NetworkError.unknownError

    func searchAppByKeyword(
        _ requestDTO: AppSearchRequestDTO
    ) async throws -> AppSearchResponseDTO {
        switch scenario {

        case .success: return appSearchResponseDTO
        case .failure: throw networkError
        }
    }
}
