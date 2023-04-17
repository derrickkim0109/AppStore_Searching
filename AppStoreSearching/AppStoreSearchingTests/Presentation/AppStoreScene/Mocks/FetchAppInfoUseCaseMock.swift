//
//  FetchAppInfoUseCaseMock.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/03/22.
//

import Foundation

final class FetchAppInfoUseCaseMock: FetchAppInfoUseCase {
    var error: Error?
    var appsInfo = AppInfoEntity.list

    func execute(
        requestValue: FetchAppInfoUseCaseRequestValue) async throws -> [AppInfoEntity] {
            if error == nil {
                return appsInfo
            } else {
                throw error ?? DataTransferError.noResponse
            }
        }
}
