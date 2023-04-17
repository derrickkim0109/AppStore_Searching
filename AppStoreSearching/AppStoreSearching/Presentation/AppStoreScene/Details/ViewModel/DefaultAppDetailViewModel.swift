//
//  DefaultAppDetailViewModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

import Foundation

final class DefaultAppDetailViewModel: AppDetailViewModel {
    private let appId: Int
    private let fetchAppInfoUseCase: FetchAppInfoUseCase

    var state: AppDetailState?

    init(
        appId: Int,
        fetchAppInfoUseCase: FetchAppInfoUseCase) {
            self.appId = appId
            self.fetchAppInfoUseCase = fetchAppInfoUseCase
        }
    
    private func fetchAppInfo(_ id: Int) async throws -> [AppInfoEntity]? {
        do {
            let result = try await fetchAppInfoUseCase.execute(
                requestValue: .init(id: id,
                                    country: "kr"))

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
        static let noInternetConnection = "인터넷 연결에 실패하였습니다."
        static let failedFetchingApps = "앱 리스트를 불러오는데 실패하였습니다."
    }
}

extension DefaultAppDetailViewModel {
    func load() async {
        do {
            guard let data = try await fetchAppInfo(appId) else {
                return
            }

            self.state = .success(data: data)
        } catch (let error) {
            self.state = .failed(error: handleFetchingProducts(error: error))
        }
    }
}
