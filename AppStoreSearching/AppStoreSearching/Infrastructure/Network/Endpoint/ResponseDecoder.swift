//
//  ResponseDecoder.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import Foundation

protocol ResponseDecoder {
    func decode<T: Decodable>(
        from data: Data) async throws -> T
}

final class DefaultJSONResponseDecoder: ResponseDecoder {
    private let decoder = JSONDecoder()
    init() {}

    func decode<T: Decodable>(
        from data: Data) async throws -> T {
        do {
            if T.self == String.self {
                return String(
                    data: data,
                    encoding: .utf8) as! T
            }

            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(
                T.self,
                from: data)
        } catch (let error) {
            throw error
        }
    }
}
