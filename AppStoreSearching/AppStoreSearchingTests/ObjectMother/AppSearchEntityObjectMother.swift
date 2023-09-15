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

    // 10개의 resultCount가 되야한다.
    static func getAppSearchEntityWithInsufficientData() -> AppSearchEntity {
        return AppSearchEntity(
            resultCount: 1,
            results: [getInsufficientAppSearchItemEntity()]
        )
    }

    static func getAppSearchItemEntityListWithCompleteData(
        count: Int = 10
    ) -> [AppSearchItemEntity] {
        return (0..<count)
            .map { _ in getCompletedAppSearchItemEntity() }
    }

    static func getCompletedAppSearchItemEntity() -> AppSearchItemEntity {
        return AppSearchItemEntity.completeDataMock
    }

    static func getInsufficientAppSearchItemEntity() -> AppSearchItemEntity {
        return AppSearchItemEntity.insufficientDataMock
    }
}
