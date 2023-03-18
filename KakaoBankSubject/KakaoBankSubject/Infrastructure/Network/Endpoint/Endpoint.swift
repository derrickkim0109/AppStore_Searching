//
//  Endpoint.swift
//  KakaoBankSubject
//
//  Created by Derrick kim on 2023/03/18.
//

protocol ResponseRequestable: Requestable {
    associatedtype Response

    var responseDecoder: ResponseDecoder { get }
}

final class Endpoint<R>: ResponseRequestable {
    typealias Response = R

    let path: String
    let isFullPath: Bool
    let method: HTTPMethod
    let headerParameters: [String: String]
    let queryParametersEncodable: Encodable?
    let queryParameters: [String: Any]
    let bodyParametersEncodable: Encodable?
    let bodyParameters: [String: Any]
    let bodyEncoding: BodyEncoding
    let responseDecoder: ResponseDecoder

    init(
        path: String,
        isFullPath: Bool = false,
        method: HTTPMethod,
        headerParameters: [String: String] = [:],
        queryParametersEncodable: Encodable? = nil,
        queryParameters: [String: Any] = [:],
        bodyParametersEncodable: Encodable? = nil,
        bodyParameters: [String: Any] = [:],
        bodyEncoding: BodyEncoding = .jsonSerializationData,
        responseDecoder: ResponseDecoder = DefaultJSONResponseDecoder()) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParameters = headerParameters
        self.queryParametersEncodable = queryParametersEncodable
        self.queryParameters = queryParameters
        self.bodyParametersEncodable = bodyParametersEncodable
        self.bodyParameters = bodyParameters
        self.bodyEncoding = bodyEncoding
        self.responseDecoder = responseDecoder
    }
}
