//
//  AppSearchDTOObjectMother.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/13.
//

@testable import AppStoreSearching

struct AppSearchDTOObjectMother {
    static func getAppSearchResponseDTOWithCompleteData() -> AppSearchResponseDTO {
        return AppSearchResponseDTO(
            resultCount: 1,
            results: [
                getAppSearchItemResponseDTOWithCompleteData()
            ]
        )
    }

    static func getAppSearchResponseDTOWithInsufficientData() -> AppSearchResponseDTO {
        return AppSearchResponseDTO(
            resultCount: 1,
            results: [
                getAppSearchItemResponseDTOWithInsufficientData()
            ]
        )
    }

    static func getAppSearchItemResponseDTOWithCompleteData() -> AppSearchItemResponseDTO {
        return AppSearchItemResponseDTO.completeDataMock
    }

    static func getAppSearchItemResponseDTOWithInsufficientData() -> AppSearchItemResponseDTO {
        return AppSearchItemResponseDTO.insufficientDataMock
    }
}
