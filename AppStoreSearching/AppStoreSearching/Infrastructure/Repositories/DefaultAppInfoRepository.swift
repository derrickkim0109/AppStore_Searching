//
//  DefaultAppInfoRepository.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

final class DefaultAppInfoRepository {
    private let dataTransferService: DataTransferService

    init(
        dataTransferService: DataTransferService) {
            self.dataTransferService = dataTransferService
        }
}

extension DefaultAppInfoRepository: AppInfoRepository {
    func fetchAppInfo(
        _ id: Int,
        _ country: String) async throws -> [AppInfoEntity] {
            let endpoint = APIEndpoints.fetchAppInfo(
                id,
                country)

            let data = try await dataTransferService.request(
                with: endpoint)

            let result = data.results.map{ $0.toDomain() }

            return result
        }
}
