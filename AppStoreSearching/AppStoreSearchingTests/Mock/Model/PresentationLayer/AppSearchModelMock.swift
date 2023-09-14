//
//  AppSearchModelMock.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/08/22.
//

@testable import AppStoreSearching

extension AppSearchModel {
    static let mock = AppSearchModel(
        resultCount: 1,
        results: [ AppSearchItemModel.mock ]
    )
}
