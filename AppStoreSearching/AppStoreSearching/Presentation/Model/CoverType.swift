//
//  CoverType.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/22.
//

import Foundation

enum CoverType: Hashable {
    case iPhone
    case iPad
}

extension CoverType {
    public var id: Self {
        self
    }
}
