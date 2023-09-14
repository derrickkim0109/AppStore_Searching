//
//  RecentKeywordObjectMother.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/13.
//

@testable import AppStoreSearching

struct RecentKeywordObjectMother {
    /// 10개 까지 가져온다.
    static func getRecentKeywordList() -> [String] {
        return [
            "카카오",
            "카카오뱅크",
            "네이버",
            "페이어블",
            "펌핑",
            "헤이딜러",
            "페이스북",
            "넷플릭스",
            "라인",
            "디스코드",
            "위챗",
            "슬랙",
            "텔레그램",
            "노션",
            "카카오맵"
        ]
    }

    static let recentKeywordListCount = getRecentKeywordList().count
}
