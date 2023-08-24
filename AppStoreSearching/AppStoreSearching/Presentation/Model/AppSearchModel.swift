//
//  AppSearchModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/22.
//

struct AppSearchModel {
    let resultCount: Int
    let results: [AppSearchItemModel]

    func hasNext(perPage : Int? = 0) -> Bool {
        return resultCount == perPage
    }
}
