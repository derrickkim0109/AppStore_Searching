//
//  AppSearchEntityMock.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/08/22.
//

extension AppSearchEntity {
    static let mock = AppSearchEntity(
        resultCount: 1,
        results: [ AppSearchItemEntity.mock ]
    )
}
