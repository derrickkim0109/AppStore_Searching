//
//  AppsInfoDTO+Mapping.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

struct AppsInfoDTO: Decodable {
    struct AppInfo: Decodable {
        let trackId: Int
        let trackName: String
        let artworkUrl512: String
        let genres: [String]
        let artistName: String
        let averageUserRating: Double
        let userRatingCountForCurrentVersion: Int
        let screenshotUrls: [String]
        let description: String
    }

    var results: [AppInfo]
}

extension AppsInfoDTO.AppInfo {
    var screenshots: [String] {
        var images = screenshotUrls
        images.insert(
            artworkUrl512,
            at: 0)
        return images
    }

    func toDomain() -> AppInfoEntity {
        return AppInfoEntity(
            id: trackId,
            name: trackName,
            icon: artworkUrl512,
            genre: genres.first,
            artistName: artistName,
            averageUserRating: averageUserRating,
            userRatingCount: userRatingCountForCurrentVersion,
            screenshots: screenshots,
            description: description)
    }
}
