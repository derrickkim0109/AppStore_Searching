//
//  AppsInfoRepository.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

protocol AppsInfoRepository {
    func fetchAppList(
        _ term: String,
        _ country: String,
        _ limit: Int) async throws -> [AppInfoEntity]
}
