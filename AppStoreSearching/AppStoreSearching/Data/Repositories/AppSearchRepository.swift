//
//  AppSearchDataSource.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

final class AppSearchRepository : AppSearchRepositoryInterface {
    private let dataSource: AppSearchDataSourceInterface

    init(
        dataSource : AppSearchDataSourceInterface
    ) {
        self.dataSource = dataSource
    }

    func searchApp(
        by keyword: String,
        page: Int,
        size: Int
    ) async throws -> AppSearchEntity {
        do {
            let requestDTO = AppSearchRequestDTO(
                keyword: keyword,
                media: "software",
                country: "kr",
                page: page,
                size: size
            )

            return try await dataSource.searchAppByKeyword(requestDTO).toEntity()
        } catch {
            throw error
        }
    }
}
