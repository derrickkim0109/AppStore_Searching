//
//  DefaultAppsInfoLisViewModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

import Foundation

final class DefaultAppsInfoLisViewModel: AppsInfoListViewModel {
    private let searchAppsInfoUseCase: SearchAppsInfoUseCase

    var state: AppsInfoListState?

    init(searchAppsInfoUseCase: SearchAppsInfoUseCase) {
        self.searchAppsInfoUseCase = searchAppsInfoUseCase
    }

    private func searchApps(_ term: String) async throws -> [AppInfoEntity]? {
        do {
            let result = try await searchAppsInfoUseCase.execute(
                requestValue: .init(
                    term: term,
                    country: Const.country,
                    limit: Const.ten))

            return result
        } catch (let error) {
            throw error
        }
    }

    private func handleFetchingProducts(
        error: Error) -> String {
            return error.isInternetConnectionError ?
            NSLocalizedString(
                Const.noInternetConnection,
                comment: Const.empty) :
            NSLocalizedString(
                Const.failedFetchingApps,
                comment: Const.empty)
        }

    private enum Const {
        static let empty = ""
        static let country = "kr"
        static let noInternetConnection = "인터넷 연결에 실패하였습니다."
        static let failedFetchingApps = "앱 리스트를 불러오는데 실패하였습니다."
        static let searchTerm = "searchTerm"
        static let zero = 0
        static let ten = 10
    }
}

extension DefaultAppsInfoLisViewModel {
    func didSearch(_ term: String) async {
        do {
            guard let data = try await searchApps(term) else {
                return
            }

            self.state = .success(data: data)
        } catch (let error) {
            self.state = .failed(error: handleFetchingProducts(error: error))
        }
    }
}
