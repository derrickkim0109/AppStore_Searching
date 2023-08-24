//
//  Dictionary.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import Foundation

extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(
                separator: "&")
            .addingPercentEncoding(
                withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}
