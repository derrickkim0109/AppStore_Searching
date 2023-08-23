//
//  AppSearchResponseDTO.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import Foundation

struct AppSearchResponseDTO: Decodable {
    let resultCount: Int
    let results: [AppSearchItemResponseDTO]
}

extension AppSearchResponseDTO {
    func toEntity() -> AppSearchEntity {
        let searchItemEntityList = results
            .map { $0.toEntity() }

        return AppSearchEntity(
            resultCount: resultCount,
            results: searchItemEntityList
        )
    }
}
