//
//  AppSearchError.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import Foundation

enum AppSearchError: String, Error {
    case invalidKeyword = "키워드는 한글 1~10자 이내로 작성해주세요"
    case failToSearchApp = "검색에 실패했습니다."
}
