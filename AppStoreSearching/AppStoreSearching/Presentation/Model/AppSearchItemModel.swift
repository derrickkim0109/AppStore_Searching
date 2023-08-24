//
//  AppSearchItemModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/22.
//

import Foundation

struct AppSearchItemModel : Hashable {
    let id = UUID()
    let screenshotUrls : [String]
    let ipadScreenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let artistViewUrl: String
    let minimumOsVersion: String
    let languages: [AppLanguageModel]
    let fileSizeBytes: String
    let sellerUrl: String
    let formattedPrice: String
    let contentAdvisoryRating: String
    let averageUserRating: Double
    let trackViewUrl: String
    let description, bundleId: String
    let isCompatible: Bool
    let releaseDate: String
    let sellerName: String
    let trackId: Int
    let trackName: String
    let currentVersionReleaseDate: String
    let releaseNotes: String
    let artistId: Int
    let artistName: String
    let genres: [String]
    let price: Int
    let version: String
    let userRatingCount: Int
}

extension AppSearchItemModel {
    // 스크린샷이 3개이상일 경우에만 캐러셀에 노출
    func showScreenShot() -> Bool {
        return screenshotUrls.count >= 3
    }
}