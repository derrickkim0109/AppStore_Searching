//
//  NetworkSessionManager.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import Foundation

protocol NetworkSessionManagerInterface {
    func request(
        _ request: URLRequest
    ) async throws -> Data
}

final class NetworkSessionManager: NetworkSessionManagerInterface {
    static let shared = NetworkSessionManager()

    private let session = URLSession.shared
    private init() {}

    func request(
        _ request: URLRequest
    ) async throws -> Data {
        let (data, response) = try await session.data(
            for: request)

        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponseError
        }

        switch response.statusCode {
        case 200..<300: return data
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
