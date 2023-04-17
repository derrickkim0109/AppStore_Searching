//
//  AppInfoRepositoryMock.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/03/22.
//


struct AppInfoRepositoryMock: AppInfoRepository {
    var result: [AppInfoEntity]
    var error: Error?

    func fetchAppInfo(
        _ id: Int,
        _ country: String) async throws -> [AppInfoEntity] {
        if error == nil {
            return result
        } else {
            throw error ?? DataTransferError.noResponse
        }
    }
}
