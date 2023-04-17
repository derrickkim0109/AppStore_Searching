//
//  SearchAppsInfoUseCase.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

protocol SearchAppsInfoUseCase {
    func execute(
        requestValue: SearchAppsInfoUseCaseRequestValue) async throws -> [AppInfoEntity]
}

final class DefaultSearchAppsInfoUseCase: SearchAppsInfoUseCase {
    private let appsInfoRepository: AppsInfoRepository

    init(appsInfoRepository: AppsInfoRepository) {
        self.appsInfoRepository = appsInfoRepository
    }

    func execute(
        requestValue: SearchAppsInfoUseCaseRequestValue) async throws -> [AppInfoEntity] {
        return try await appsInfoRepository.fetchAppList(
            requestValue.term,
            requestValue.country,
            requestValue.limit)
    }
}

struct SearchAppsInfoUseCaseRequestValue {
    let term: String
    let country: String
    let limit: Int
}
