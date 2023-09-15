//
//  MockNetworkSessionManager.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/15.
//

import Foundation
@testable import AppStoreSearching

struct NetworkSessionManagerMock: NetworkSessionManagerInterface {
    let response: HTTPURLResponse?
    let data: Data?

    func request(
        _ request: URLRequest
    ) async throws -> Data {
        guard let response = response else {
            throw NetworkError.invalidResponseError
        }

        switch response.statusCode {
        case 200..<300:
            if let data = data {
                return data
            } else {
                throw NetworkError.unknownError
            }

        case 400:               throw NetworkError.badRequestError
        case 401:               throw NetworkError.unauthorizedError
        case 403:               throw NetworkError.forbiddenError
        case 404:               throw NetworkError.notFoundError
        case 500:               throw NetworkError.serverError
        case 402, 405...499:    throw NetworkError.error4xx(response.statusCode)
        case 501...599:         throw NetworkError.error5xx(response.statusCode)
        default:                throw NetworkError.unknownError
        }
    }
}
