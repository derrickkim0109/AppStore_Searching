//
//  NetworkServiceMocks.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/03/22.
//

import Foundation

struct NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(
        string: "https://itunes.apple.com")!

    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
