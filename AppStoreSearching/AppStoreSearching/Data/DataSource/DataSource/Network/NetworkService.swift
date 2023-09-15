//
//  NetworkService.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import Foundation

protocol NetworkServiceInterface {
    func request<N: Networkable, T: Decodable>(
        endpoint: N
    ) async throws -> T where N.Response == T
}

final class NetworkService: NetworkServiceInterface {
    private let sessionManager: NetworkSessionManagerInterface

    init(
        sessionManager: NetworkSessionManagerInterface = NetworkSessionManager.shared
    ) {
        self.sessionManager = sessionManager
    }

    @MainActor
    func request<N: Networkable, T: Decodable>(
        endpoint: N
    ) async throws -> T where N.Response == T {
        do {
            let urlRequest = try endpoint.makeURLRequest()

            let data = try await sessionManager.request(urlRequest)
            return try await decode(from: data)
        } catch (let error) {
            if let networkError = error as? NetworkError {
                throw networkError
            } else {
                throw NetworkError.unknownError
            }
        }
    }

    private func decode<T: Decodable>(
        from data: Data
    ) async throws -> T {
        do {
            return try JSONDecoder().decode(
                T.self,
                from: data
            )
        } catch (let error) {
            if let decodingError = error as? DecodingError {
                throw NetworkError.decodingError(
                    decodingError.localizedDescription
                )
            } else if let networkError = error as? NetworkError {
                throw networkError
            }
            
            throw NetworkError.unknownError
        }
    }
}
