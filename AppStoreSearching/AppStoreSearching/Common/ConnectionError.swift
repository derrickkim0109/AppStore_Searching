//
//  ConnectionError.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

protocol ConnectionError: Error {
    var isInternetConnectionError: Bool { get }
}

extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError,
              error.isInternetConnectionError else {
            return false
        }

        return true
    }
}
