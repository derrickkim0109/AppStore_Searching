//
//  String+Extensions.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

extension String {
    func hasCaseInsensitivePrefix(_ s: String) -> Bool {
        return prefix(s.count).caseInsensitiveCompare(s) == .orderedSame
    }
}
