//
//  AppSearchRepositoryInterface.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

protocol AppSearchRepositoryInterface {
    func searchApp(
        by keyword: String,
        page: Int,
        size: Int
    ) async throws -> AppSearchEntity
}
