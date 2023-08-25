//
//  RecentKeywordRepositoryInterface.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

protocol RecentKeywordRepositoryInterface {
    func getRecentKeywordList() -> [String]
    func add(
        recentKeyword: String
    )
}
