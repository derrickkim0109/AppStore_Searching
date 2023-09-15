//
//  AppSearchDataSource.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import Foundation

protocol AppSearchDataSourceInterface {
    func searchAppByKeyword(
        _ requestDTO: AppSearchRequestDTO
    ) async throws -> AppSearchResponseDTO
}

final class AppSearchDataSource : AppSearchDataSourceInterface {
    private let networkService: NetworkServiceInterface
    
    init(
        networkService: NetworkServiceInterface
    ) {
        self.networkService = networkService
    }
    
    func searchAppByKeyword(
        _ requestDTO: AppSearchRequestDTO
    ) async throws -> AppSearchResponseDTO {
        
        let apiEndPoint = AppSearchAPIEndpoint.searchAppByKeyword(requestDTO)
        
        return try await networkService.request(
            endpoint: apiEndPoint
        )
    }
}
