//
//  AppSearchModelMock.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/08/22.
//

import Foundation

extension AppSearchModel {
    static let mock = AppSearchModel(
        resultCount: 1,
        results: [ AppSearchItemModel.mock ]
    )
}
