//
//  AppsInfoRepositoryMock.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/03/22.
//

//import XCTest
//
//struct AppsInfoRepositoryMock: AppsInfoRepository {
//    var result: [AppInfoEntity]
//    var error: Error?
//
//    func fetchAppList(
//        _ term: String,
//        _ country: String,
//        _ limit: Int) async throws -> [AppInfoEntity] {
//        if error == nil {
//            return result
//        } else {
//            throw error ?? DataTransferError.noResponse
//        }
//    }
//}
