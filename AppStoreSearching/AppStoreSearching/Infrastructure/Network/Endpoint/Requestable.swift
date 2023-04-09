//
//  Requestable.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import Foundation

enum RequestGenerationError: Error {
    case components
}

protocol Requestable {
    var path: String { get }
    var isFullPath: Bool { get }
    var method: HTTPMethod { get }
    var headerParameters: [String: String] { get }
    var queryParametersEncodable: Encodable? { get }
    var queryParameters: [String: Any] { get }
    var bodyParametersEncodable: Encodable? { get }
    var bodyParameters: [String: Any] { get }
    var bodyEncoding: BodyEncoding { get }

    func urlRequest(
        with networkConfig: NetworkConfigurable) throws -> URLRequest
}

extension Requestable {
    func url(
        with config: NetworkConfigurable) throws -> URL {
        let baseURL = config.baseURL.absoluteString
        let endpoint = isFullPath ? path : baseURL.appending(path)

        guard var urlComponents = URLComponents(
            string: endpoint) else {
            throw RequestGenerationError.components
        }

        var urlQueryItems = [URLQueryItem]()

        let queryParameters = try queryParametersEncodable?.toDictionary() ?? queryParameters
        queryParameters.forEach {
            urlQueryItems.append(
                URLQueryItem(name: $0.key,
                             value: "\($0.value)"))
        }

        config.queryParameters.forEach {
            urlQueryItems.append(
                URLQueryItem(name: $0.key,
                             value: $0.value))
        }

        urlComponents.queryItems = urlQueryItems.isEmpty ? nil : urlQueryItems

        guard let url = urlComponents.url else {
            throw RequestGenerationError.components
        }

        return url
    }

    func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        let url = try url(with: config)
        var urlRequest = URLRequest(
            url: url)

        var allHeaders: [String: String] = config.headers
        headerParameters.forEach {
            allHeaders.updateValue(
                $1,
                forKey: $0)
        }

        let bodyParameters = try bodyParametersEncodable?.toDictionary() ?? bodyParameters
        if !bodyParameters.isEmpty {
            urlRequest.httpBody = encodeBody(
                bodyParameters: bodyParameters,
                bodyEncoding: bodyEncoding)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders

        return urlRequest
    }

    private func encodeBody(
        bodyParameters: [String: Any],
        bodyEncoding: BodyEncoding) -> Data? {
        switch bodyEncoding {
        case .jsonSerializationData:
            return try? JSONSerialization.data(
                withJSONObject: bodyParameters,
                options: .init())
        case .stringEncodingAscii:
            return bodyParameters.queryString.data(
                using: String.Encoding.ascii,
                allowLossyConversion: true)
        }
    }
}

private extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(
                separator: "&")
            .addingPercentEncoding(
                withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}

extension Encodable {
    func toEncode() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func toDictionary() throws -> [String: Any]? {
        let jsonData = try JSONSerialization.jsonObject(
            with: self.toEncode())
        return jsonData as? [String : Any]
    }
}
