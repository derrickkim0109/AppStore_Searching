//
//  AppSearchModelObjectMother.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/13.
//

@testable import AppStoreSearching

struct AppSearchModelObjectMother {
    static func getAppSearchModelWithCompleteData() -> AppSearchModel {
        return AppSearchModel(
            resultCount: 10,
            results: getAppSearchItemModelListWithCompleteData()
        )
    }

    static func getAppSearchModelWithEmptyData() -> AppSearchModel {
        return AppSearchModel(
            resultCount: 0,
            results: []
        )
    }

    static func getAppSearchModelWithInsufficientData() -> AppSearchModel {
        return AppSearchModel(
            resultCount: 5,
            results: getAppSearchItemModelListWithCompleteData(count: 5)
        )
    }

    /// Default Page count가 10이다.
    static func getAppSearchItemModelListWithCompleteData(
        count: Int = 10
    ) -> [AppSearchItemModel] {
        return (0..<count)
            .map { _ in getAppSearchItemModelWithCompleteData() }
    }

    static func getAppSearchItemModelWithCompleteData() -> AppSearchItemModel {
        return AppSearchItemModel.mock
    }
}
