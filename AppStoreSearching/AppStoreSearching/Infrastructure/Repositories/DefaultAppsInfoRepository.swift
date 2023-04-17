//
//  DefaultAppsInfoRepository.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

final class DefaultAppsInfoRepository {
    private let dataTransferService: DataTransferService

    init(
        dataTransferService: DataTransferService) {
            self.dataTransferService = dataTransferService
        }
}

extension DefaultAppsInfoRepository: AppsInfoRepository {
    func fetchAppList(
        _ term: String,
        _ country: String,
        _ limit: Int) async throws -> [AppInfoEntity] {
            let endpoint = APIEndpoints.fetchAppsInfo(
                term,
                country,
                limit)

            let data = try await dataTransferService.request(
                with: endpoint)

            let result = data.results.map{ $0.toDomain() }

            return result
        }
}
