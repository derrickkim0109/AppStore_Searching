//
//  AppInfoRepository.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

protocol AppInfoRepository {
    func fetchAppInfo(
        _ id: Int,
        _ country: String) async throws -> [AppInfoEntity]
}
