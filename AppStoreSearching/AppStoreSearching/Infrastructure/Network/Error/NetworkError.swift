//
//  NetworkError.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import Foundation

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

extension NetworkError {
    public var isNotFoundError: Bool {
        return hasStatusCode(404)
    }

    public func hasStatusCode(
        _ codeError: Int) -> Bool {
            switch self {
            case let .error(code, _):
                return code == codeError
            default:
                return false
            }
        }
}
