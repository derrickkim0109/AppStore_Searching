//
//  DataTransferService.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import Foundation

protocol DataTransferService {
    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(
                    with endpoint: E) async throws -> T  where E.Response == T
    func request<E: ResponseRequestable>(
        with endpoint: E) async throws where E : ResponseRequestable, E.Response == ()
}

final class DefaultDataTransferService {
    private let networkService: NetworkService

    init(with networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension DefaultDataTransferService: DataTransferService {
    @MainActor
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E) async throws -> T {
        do {
            let data = try await networkService.request(
                endpoint: endpoint)

            let result: T = try await decode(
                data: data,
                decoder: endpoint.responseDecoder)
            return result
        } catch (let error) {
            throw resolve(
                error: error)
        }
    }

    @MainActor
    func request<E>(
        with endpoint: E) async throws where E : ResponseRequestable, E.Response == () {
        do {
            try await networkService.request(
                endpoint: endpoint)
        } catch (let error) {
            throw resolve(error: error)
        }
    }

    private func decode<T: Decodable>(
        data: Data?,
        decoder: ResponseDecoder) async throws -> T {
        do {
            guard let data = data else {
                throw DataTransferError.noResponse
            }

            return try await decoder.decode(
                from: data)
        } catch (let error) {
            throw DataTransferError.parsing(error)
        }
    }

    private func resolve(
        error: Error) -> DataTransferError {
        return error is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(error)
    }
}

protocol DataTransferErrorResolver {
    func resolve(
        error: NetworkError) -> Error
}
