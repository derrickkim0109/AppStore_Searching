//
//  RecentKeywordStorage.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import Foundation

protocol RecentKeywordStorageInterface {
    func getRecentKeywordList() -> [String]
    func addRecentKeyword(
        keyword: String
    )
}

final class RecentKeywordStorage: RecentKeywordStorageInterface {
    private let RECENT_KEYWORD = "RECENT_KEYWORD"
    private let limitCount: Int = 30

    func getRecentKeywordList() -> [String] {
        guard let recentKeywordList = UserDefaults.standard.stringArray(
            forKey: RECENT_KEYWORD
        ) else {
            return []
        }

        return recentKeywordList
    }

    func addRecentKeyword(
        keyword: String
    ) {
        var recentKeywordList = UserDefaults.standard.stringArray(
            forKey: RECENT_KEYWORD
        ) ?? []

        if isAlreadyExistence(keyword: keyword) {
            recentKeywordList.move(
                keyword,
                to: 0
            )
        } else if isLimit() {
            let lastIndex = recentKeywordList.count - 1
            recentKeywordList.remove(
                at: lastIndex
            )

            recentKeywordList.insert(
                keyword,
                at: 0
            )

        } else {
            recentKeywordList.insert(
                keyword,
                at: 0
            )
        }

        UserDefaults.standard.setValue(
            recentKeywordList,
            forKey: RECENT_KEYWORD
        )
    }

    private func isAlreadyExistence(
        keyword: String
    ) -> Bool {
        let recentKeywordList = UserDefaults.standard.stringArray(
            forKey: RECENT_KEYWORD
        ) ?? []
        
        return recentKeywordList.contains(keyword)
    }

    private func isLimit() -> Bool {
        let recentKeywordList = UserDefaults.standard.stringArray(
            forKey: RECENT_KEYWORD
        ) ?? []

        return recentKeywordList.count > limitCount
    }
}

