//
//  AppSearchEntityObjectMother.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/13.
//

@testable import AppStoreSearching

//MARK: 테스트할 Instance를 만들어주는 객체

struct AppSearchEntityObjectMother {
    /// page count가 10이다.
    static func getAppSearchEntityWithCompleteData() -> AppSearchEntity {
        return AppSearchEntity(
            resultCount: 10,
            results: getAppSearchItemEntityListWithCompleteData()
        )
    }

    static func getAppSearchEntityWithEmptyData() -> AppSearchEntity {
        return AppSearchEntity(
            resultCount: 0,
            results: []
        )
    }

    static func getAppSearchEntityWithInsufficientData() -> AppSearchEntity {
        return AppSearchEntity(
            resultCount: 5,
            results: getAppSearchItemEntityListWithCompleteData(count: 5)
        )
    }

    static func getAppSearchItemEntityListWithCompleteData(
        count: Int = 10
    ) -> [AppSearchItemEntity] {
        return (0..<count)
            .map { _ in getAppSearchItemModelWithCompleteData() }
    }

    static func getAppSearchItemModelWithCompleteData() -> AppSearchItemEntity {
        return AppSearchItemEntity.mock
    }
}
