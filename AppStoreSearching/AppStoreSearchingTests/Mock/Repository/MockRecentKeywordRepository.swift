//
//  MockRecentKeywordRepository.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/14.
//

@testable import AppStoreSearching

final class MockRecentKeywordRepository: RecentKeywordRepositoryInterface {
    var scenario: Scenario = .success
    var recentKeywordList: [String] = RecentKeywordObjectMother.getRecentKeywordList()

    func getRecentKeywordList() -> [String] {
        switch scenario {
        case .success:
            return recentKeywordList
        case .failure:
            return []
        }
    }

    func add(keyword: String) { }
}
