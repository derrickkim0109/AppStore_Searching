//
//  Encodable.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/21.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let jsonObject = try JSONSerialization.jsonObject(
            with: self.toEncode()
        )
        return jsonObject as? [String : Any]
    }
    
    private func toEncode() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
