//
//  AppSearchModelMapper.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/22.
//

struct AppSearchModelMapper {
    static func toPresentationModel(
        entity: AppSearchEntity?
    ) -> AppSearchModel {
        let appSearchItemModelList = entity?.results
            .map {
                let languageList = $0.languages
                    .compactMap {
                        AppLanguageModel(rawValue: $0.rawValue)
                    }
                
                return AppSearchItemModel(
                    screenshotUrls: $0.screenshotUrls,
                    ipadScreenshotUrls: $0.ipadScreenshotUrls,
                    artworkUrl60: $0.artworkUrl60,
                    artworkUrl512: $0.artworkUrl512,
                    artworkUrl100: $0.artworkUrl100,
                    artistViewUrl: $0.artistViewUrl,
                    minimumOsVersion: $0.minimumOsVersion,
                    languages: languageList,
                    fileSizeBytes: $0.fileSizeBytes,
                    sellerUrl: $0.sellerUrl,
                    formattedPrice: $0.formattedPrice,
                    contentAdvisoryRating: $0.contentAdvisoryRating,
                    averageUserRating: $0.averageUserRating,
                    trackViewUrl: $0.trackViewUrl,
                    description: $0.description,
                    bundleId: $0.bundleId,
                    isCompatible: $0.isCompatible,
                    releaseDate: $0.releaseDate,
                    sellerName: $0.sellerName,
                    trackId: $0.trackId,
                    trackName: $0.trackName,
                    currentVersionReleaseDate: $0.currentVersionReleaseDate,
                    releaseNotes: $0.releaseNotes,
                    artistId: $0.artistId,
                    artistName: $0.artistName,
                    genres: $0.genres,
                    price: $0.price,
                    version: $0.version,
                    userRatingCount: $0.userRatingCount
                )
            }
        
        return AppSearchModel(
            resultCount: entity?.resultCount ?? 0,
            results: appSearchItemModelList ?? []
        )
    }
}

