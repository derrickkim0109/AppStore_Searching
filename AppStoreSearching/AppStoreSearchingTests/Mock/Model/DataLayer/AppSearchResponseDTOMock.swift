//
//  AppSearchResponseDTOMock.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/08/22.
//

@testable import AppStoreSearching

extension AppSearchResponseDTO {
    static let mock = AppSearchResponseDTO(
        resultCount: 1,
        results: [ AppSearchItemResponseDTO.completeDataMock ]
    )
}
