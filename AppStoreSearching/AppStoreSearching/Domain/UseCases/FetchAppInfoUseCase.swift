//
//  FetchAppInfoUseCase.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

protocol FetchAppInfoUseCase {
    func execute(
        requestValue: FetchAppInfoUseCaseRequestValue) async throws -> [AppInfoEntity]
}

final class DefaultFetchAppInfoUseCase: FetchAppInfoUseCase {
    private let appInfoRepository: AppInfoRepository

    init(appInfoRepository: AppInfoRepository) {
        self.appInfoRepository = appInfoRepository
    }

    func execute(
        requestValue: FetchAppInfoUseCaseRequestValue) async throws -> [AppInfoEntity] {
            return try await appInfoRepository.fetchAppInfo(
                requestValue.id,
                requestValue.country)
    }
}

struct FetchAppInfoUseCaseRequestValue {
    let id: Int
    let country: String
}
