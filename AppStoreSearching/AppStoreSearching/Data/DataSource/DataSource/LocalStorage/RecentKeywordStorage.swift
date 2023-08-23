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

    //MARK: UserDefault에서 최근검색어목록 가져오기
    func getRecentKeywordList() -> [String] {
        guard let recentKeywordList = UserDefaults.standard.stringArray(
            forKey: RECENT_KEYWORD
        ) else {
            return []
        }

        return recentKeywordList
    }

    //MARK: UserDefault에 최근검색어 추가 - 중복저장을 막아야함, 순서 필요
    func addRecentKeyword(
        keyword: String
    ) {
        var recentKeywordList = UserDefaults.standard.stringArray(
            forKey: RECENT_KEYWORD
        ) ?? []

        if isAlreadyExist(keyword: keyword) {
            //이미 최근검색어목록에 존재할 경우 새롭게 추가하지 않고 가장 첫번째 인덱스로 위치시킴
            recentKeywordList.move(
                keyword,
                to: 0
            )
        } else if isLimit() {
            // 가장 마지막 최근검색어를 삭제하고 새로운 항목을 추가
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

    //MARK: 최근검색어목록에 키워드가 들어있는지 확인
    private func isAlreadyExist(
        keyword: String
    ) -> Bool {
        let recentKeywordList = UserDefaults.standard.stringArray(
            forKey: RECENT_KEYWORD
        ) ?? []
        
        return recentKeywordList.contains(keyword)
    }

    //MARK: 최근검색어목록에 Limit까지 데이터 들어있나 확인
    private func isLimit() -> Bool {
        let recentKeywordList = UserDefaults.standard.stringArray(
            forKey: RECENT_KEYWORD
        ) ?? []

        return recentKeywordList.count > limitCount
    }
}

