//
//  HTTPMethod.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

enum HTTPMethod: String {
    case get = "GET"
}

enum HTTPPath {
    case search
    case lookup

    var value: String {
        switch self {
        case .search:
            return "/search"
        case .lookup:
            return "/lookup"
        }
    }
}

enum HTTPHeaderField {
    private static let identifier = "identifier"
    private static let applicationJSON = "application/json"
    private static let contentType = "Content-Type"

    case json

    var header: [String: String] {
        switch self {
        case .json:
            return [HTTPHeaderField.contentType: HTTPHeaderField.applicationJSON,
                    HTTPHeaderField.identifier: ""]
        }
    }
}
