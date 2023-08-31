//
//  AppSearchAPIEndpoint.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

struct AppSearchAPIEndpoint {
    static func searchAppByKeyword(
        _ requestDTO: AppSearchRequestDTO
    ) -> Endpoint<AppSearchResponseDTO> {
        return Endpoint(
            path: "/search",
            httpMethod: .get,
            headerParameters: ["Content-Type" : "application/json"],
            queryParameters: requestDTO
        )
    }
}
