//
//  AppInfoModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/13.
//

struct AppInfoModel: Hashable {
    let info: [String]
    let type: InfoType
}

enum InfoType: String {
    case provider = "제공자"
    case size = "크기"
    case category = "카테고리"
    case compatibility = "호환성"
    case language = "언어"
    case contentAdvisoryRating = "연령 등급"
}
