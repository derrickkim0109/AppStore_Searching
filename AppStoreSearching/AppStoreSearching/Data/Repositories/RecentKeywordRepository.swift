//
//  RecentKeywordRepository.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import Foundation

final class RecentKeywordRepository: RecentKeywordRepositoryInterface {
    private let recentKeywordStorage: RecentKeywordStorageInterface

    init(recentKeywordStorage : RecentKeywordStorageInterface) {
        self.recentKeywordStorage = recentKeywordStorage
    }

    func getRecentKeywordList() -> [String] {
        return recentKeywordStorage.getRecentKeywordList()
    }

    func addRecentKeyword(keyword: String) {
        recentKeywordStorage.addRecentKeyword(keyword: keyword)
    }
}
