//
//  AppsInfoListViewModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

protocol AppsInfoListViewModelInput {
    func didSearch(_ term: String) async
}

protocol AppsInfoListViewModelOutput {
    var state: AppsInfoListState? { get }
}

protocol AppsInfoListViewModel: AppsInfoListViewModelInput, AppsInfoListViewModelOutput {}

enum AppsInfoListState {
    case success(data: [AppInfoEntity])
    case failed(error: String)
}
