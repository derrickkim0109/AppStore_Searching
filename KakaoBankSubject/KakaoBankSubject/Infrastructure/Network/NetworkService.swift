//
//  NetworkService.swift
//  KakaoBankSubject
//
//  Created by Derrick kim on 2023/03/18.
//

import Foundation

protocol NetworkService {
    @discardableResult
    func request(
        endpoint: Requestable) async throws -> Data?
}

final class DefaultNetworkService: NetworkService {
    private let config: NetworkConfigurable
    private let sessionManager: NetworkSessionManager

    init(
        config: NetworkConfigurable,
        sessionManager: NetworkSessionManager = DefaultNetworkSessionManager.shared) {
        self.config = config
        self.sessionManager = sessionManager
    }

    func request(
        endpoint: Requestable) async throws -> Data? {
        do {
            let urlRequest = try endpoint.urlRequest(
                with: config)

            return try await sessionManager.request(urlRequest)
        } catch (let error) {
            throw error
        }
    }
}
