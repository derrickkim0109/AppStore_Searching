//
//  AppSearchRequestDTO.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import Foundation

struct AppSearchRequestDTO: Encodable {
    let keyword: String
    let media : String
    let country : String
    let page : Int
    let size : Int

    enum CodingKeys: String, CodingKey {
        case keyword = "term"
        case media
        case country
        case page = "offset"
        case size = "limit"
    }
}
