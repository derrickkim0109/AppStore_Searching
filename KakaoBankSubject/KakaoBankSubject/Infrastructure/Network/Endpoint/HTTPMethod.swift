//
//  HTTPMethod.swift
//  KakaoBankSubject
//
//  Created by Derrick kim on 2023/03/18.
//

enum HTTPMethod: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

enum HTTPPath {
    static let basePath = "/api/products"
    case products
    case productDetail(_ productID: Int)
    case getProductSecret(_ productID: Int)
    case motifyProduct(_ productID: Int)
    case delete(deleteURI: String)

    var value: String {
        switch self {
        case .products:
            return HTTPPath.basePath
        case .productDetail(let productID):
            return HTTPPath.basePath + "/\(productID)/"
        case .getProductSecret(let productID):
            return HTTPPath.basePath + "/\(productID)/archived"
        case .motifyProduct(let productID):
            return HTTPPath.basePath + "/\(productID)/"
        case .delete(let deleteURI):
            return "\(deleteURI)"
        }
    }
}

enum HTTPHeader {
    private static let identifier = "identifier"
    private static let applicationJSON = "application/json"
    private static let contentType = "Content-Type"

    case json

    var header: [String: String] {
        switch self {
        case .json:
            return [HTTPHeader.contentType: HTTPHeader.applicationJSON,
                    HTTPHeader.identifier: ""]
        }
    }
}
