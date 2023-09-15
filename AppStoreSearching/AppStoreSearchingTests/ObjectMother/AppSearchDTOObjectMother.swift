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
            resultCount: 10,
            results: getAppSearchItemResponseDTOWithCompleteData()
        )
    }

    static func getAppSearchResponseDTOWithInsufficientData() -> AppSearchResponseDTO {
        return AppSearchResponseDTO(
            resultCount: 1,
            results: [
                getInsufficientAppSearchItemResponseDTO()
            ]
        )
    }

    static func getAppSearchItemResponseDTOWithCompleteData(
        count: Int = 10
    ) -> [AppSearchItemResponseDTO] {
        return (0..<count)
            .map { _ in getCompletedAppSearchItemResponseDTO() }
    }

    static func getCompletedAppSearchItemResponseDTO() -> AppSearchItemResponseDTO {
        return AppSearchItemResponseDTO.completeDataMock
    }

    static func getInsufficientAppSearchItemResponseDTO() -> AppSearchItemResponseDTO {
        return AppSearchItemResponseDTO.insufficientDataMock
    }
}
