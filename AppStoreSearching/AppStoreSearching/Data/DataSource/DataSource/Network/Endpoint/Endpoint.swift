//
//  Endpoint.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

protocol Networkable: Requestable, Responsable { }

final class Endpoint<R>: Networkable {
    typealias Response = R

    let path: String
    let httpMethod: HTTPMethod
    let headerParameters: [String: String]
    let queryParameters: Encodable?
    let bodyParameters: Encodable?

    init(
        path: String,
        httpMethod: HTTPMethod,
        headerParameters: [String: String] = [:],
        queryParameters: Encodable? = nil,
        bodyParameters: Encodable? = nil
    ) {
        self.path = path
        self.httpMethod = httpMethod
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
    }
}
