//
//  DataTransferError.swift
//  KakaoBankSubject
//
//  Created by Derrick kim on 2023/03/18.
//

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(Error)
    case resolvedNetworkFailure(Error)
}

extension DataTransferError: ConnectionError {
    var isInternetConnectionError: Bool {
        guard case let DataTransferError.networkFailure(networkError) = self,
              case NetworkError.notConnected = networkError else {
            return false
        }
        return true
    }
}
