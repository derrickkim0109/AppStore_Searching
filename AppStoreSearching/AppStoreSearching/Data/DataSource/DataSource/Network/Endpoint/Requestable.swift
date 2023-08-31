//
//  Requestable.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import Foundation

protocol Responsable {
    associatedtype Response
}

protocol Requestable {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headerParameters: [String: String] { get }
    var queryParameters: Encodable? { get }
    var bodyParameters: Encodable? { get }

    func makeURLRequest() throws -> URLRequest
}

extension Requestable {
    func makeURLRequest() throws -> URLRequest {
        guard var urlComponent = try makeURLComponents() else {
            throw NetworkError.urlComponentError
        }

        if let queryItems = try getQueryParameters() {
            urlComponent.queryItems = queryItems
        }

        guard let url = urlComponent.url else {
            throw NetworkError.urlComponentError
        }

        var urlRequest = URLRequest(
            url: url
        )

        if let httpBody = try getBodyParameters() {
            urlRequest.httpBody = httpBody
        }

        urlRequest.allHTTPHeaderFields = headerParameters
        urlRequest.httpMethod = httpMethod.rawValue

        return urlRequest
    }

    private func makeURLComponents() throws -> URLComponents? {
        guard let baseURL = Bundle.main.infoDictionary?["APIBaseURL"] as? String else {
            throw NetworkError.makeURLError
        }
        
        guard let urlComponents = URLComponents(
            string: baseURL + path) else {
            throw NetworkError.urlComponentError
        }

        return urlComponents
    }

    private func getQueryParameters() throws -> [URLQueryItem]? {
        guard let queryParameters else {
            return nil
        }

        guard let queryDictionary = try? queryParameters.toDictionary() else {
            throw NetworkError.queryEncodingError
        }

        var queryItemList : [URLQueryItem] = []

        queryItemList = queryDictionary.map {
            URLQueryItem(
                name: $0.key,
                value: "\($0.value)"
            )
        }

        if queryItemList.isEmpty {
            return nil
        }

        return queryItemList
    }

    private func getBodyParameters() throws -> Data? {
        guard let bodyParameters else {
            return nil
        }

        guard let bodyDictionary = try? bodyParameters.toDictionary() else {
            throw NetworkError.bodyEncodingError
        }

        guard let encodedBody = try? JSONSerialization.data(
            withJSONObject: bodyDictionary
        ) else {
            throw NetworkError.bodyEncodingError
        }

        return encodedBody
    }
}
