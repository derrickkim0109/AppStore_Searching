//
//  AppSearchResponseDTOMock.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/08/22.
//

import Foundation

extension AppSearchResponseDTO {
    static let mock = AppSearchResponseDTO(
        resultCount: 1,
        results: [ AppSearchItemResponseDTO.completeDataMock ]
    )
}
