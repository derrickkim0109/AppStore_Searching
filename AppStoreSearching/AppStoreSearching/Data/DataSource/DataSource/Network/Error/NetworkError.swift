//
//  NetworkError.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import Foundation

enum NetworkError: Error, Equatable {
    case urlComponentError
    case queryEncodingError
    case bodyEncodingError
    case makeURLError

    case invalidRequestError
    case invalidResponseError
    case badRequestError
    case unauthorizedError
    case forbiddenError
    case notFoundError
    case serverError
    case unknownError
    
    case error4xx(_ code: Int)
    case error5xx(_ code: Int)
    case decodingError( _ description: String)
}
