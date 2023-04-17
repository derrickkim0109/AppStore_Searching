//
//  APIEndpoints.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

struct APIEndpoints {
    static func fetchAppsInfo(
        _ term: String,
        _ country: String,
        _ limit: Int) -> Endpoint<AppsInfoDTO> {
            return Endpoint(
                path: HTTPPath.search.value,
                method: .get,
                queryParameters: ["term": term,
                                  "country": country,
                                  "limit": limit,
                                  "entity": "software"])
        }

    static func fetchAppInfo(
        _ id: Int,
        _ country: String) -> Endpoint<AppsInfoDTO> {
            return Endpoint(
                path: HTTPPath.lookup.value,
                method: .get,
                queryParameters: ["id": id,
                                  "country": country])
        }
}
