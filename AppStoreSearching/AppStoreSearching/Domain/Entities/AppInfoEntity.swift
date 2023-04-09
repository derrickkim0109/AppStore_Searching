//
//  AppInfoEntity.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

struct AppInfoEntity: Hashable {
    let id: Int
    let name: String
    let icon: String
    let genre: String?
    let artistName: String
    let averageUserRating: Double
    let userRatingCount: Int
    let screenshots: [String]
    let description: String
}
