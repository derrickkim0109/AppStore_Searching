//
//  AppSearchItemResponseDTO.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import UIKit

struct AppSearchItemResponseDTO: Decodable {
    let screenshotUrls: [String]?
    let ipadScreenshotUrls: [String]?
    let artworkUrl60: String?
    let artworkUrl512: String?
    let artworkUrl100: String?
    let artistViewUrl: String?
    let minimumOsVersion: String?
    let languageCodesISO2A: [String]?
    let fileSizeBytes: String?
    let sellerUrl: String?
    let formattedPrice: String?
    let contentAdvisoryRating: String?
    let averageUserRating: Double?
    let trackViewUrl: String?
    let description, bundleId: String?
    let supportedDevices: [String]?
    let releaseDate: String?
    let sellerName: String?
    let trackId: Int?
    let trackName: String?
    let currentVersionReleaseDate: String?
    let releaseNotes: String?
    let artistId: Int?
    let artistName: String?
    let genres: [String]?
    let price: Int?
    let version: String?
    let userRatingCount: Int?
}

extension AppSearchItemResponseDTO {
    func toEntity() -> AppSearchItemEntity {
        return AppSearchItemEntity(
            screenshotUrls: screenshotUrls ?? [],
            ipadScreenshotUrls: ipadScreenshotUrls ?? [],
            artworkUrl60: artworkUrl60 ?? "",
            artworkUrl512: artworkUrl512 ?? "",
            artworkUrl100: artworkUrl100 ?? "",
            artistViewUrl: artistViewUrl ?? "",
            minimumOsVersion: minimumOsVersion ?? "",
            languages: toAppStoreLanguageCodeEntity() ?? [],
            fileSizeBytes: fileSizeBytes ?? "",
            sellerUrl: sellerUrl ?? "",
            formattedPrice: formattedPrice ?? "",
            contentAdvisoryRating: contentAdvisoryRating ?? "",
            averageUserRating: averageUserRating ?? 0,
            trackViewUrl: trackViewUrl ?? "",
            description: description ?? "",
            bundleId: bundleId ?? "",
            isCompatible: isCompatibleToDevice(),
            releaseDate: releaseDate ?? "",
            sellerName: sellerName ?? "",
            trackId: trackId ?? 0,
            trackName: trackName ?? "",
            currentVersionReleaseDate: currentVersionReleaseDate ?? "",
            releaseNotes: releaseNotes ?? "",
            artistId: artistId ?? 0,
            artistName: artistName ?? "",
            genres: genres ?? [],
            price: price ?? 0,
            version: version ?? "",
            userRatingCount: userRatingCount ?? 0
        )
    }

    func toAppStoreLanguageCodeEntity() -> [AppLanguageCodeEntity]? {
        guard var languageCodes = languageCodesISO2A else {
            return nil
        }

        if let indexOfKO = languageCodes.firstIndex(of: "KO") {
            let ko = languageCodes.remove(at: indexOfKO)
            languageCodes.insert(ko, at: 0)

            if let indexOfEN = languageCodes.firstIndex(of: "EN") {
                let en = languageCodes.remove(at: indexOfEN)
                languageCodes.insert(en, at: 1)
            }

        } else if let indexOfEN = languageCodes.firstIndex(of: "EN") {
            let en = languageCodes
                .remove(
                    at: indexOfEN
                )
            languageCodes.insert(en, at: 0)
        }

        return languageCodes.compactMap { code in
            return AppLanguageCodeEntity(
                rawValue: code
            )
        }
    }

    func isCompatibleToDevice(
        deviceModel: String = UIDevice.current.modelName
    ) -> Bool {
        return supportedDevices?.contains(
            deviceModel.getFormattedDeviceName()) == true
    }
}
