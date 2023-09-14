//
//  MockNetworkService.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/13.
//

@testable import AppStoreSearching

final class MockNetworkService: NetworkServiceInterface {
    var scenario: Scenario = .success

    var appSearchResponseDTO: AppSearchResponseDTO = AppSearchDTOObjectMother.getAppSearchResponseDTOWithCompleteData()
    var networkError = NetworkError.unknownError

    func request<N, T>(
        endpoint: N
    ) async throws -> T where N : Networkable, T : Decodable, T == N.Response {
        guard let responseData = appSearchResponseDTO as? T else {
            throw networkError
        }

        switch scenario {
        case .success: return responseData
        case .failure: throw networkError
        }
    }
}
