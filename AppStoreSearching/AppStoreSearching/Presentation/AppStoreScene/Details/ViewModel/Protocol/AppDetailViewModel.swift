//
//  AppDetailViewModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

protocol AppDetailViewModelInput {
    func load() async
}

protocol AppDetailViewModelOutput {
    var state: AppDetailState? { get }
}

protocol AppDetailViewModel: AppDetailViewModelInput, AppDetailViewModelOutput {}

enum AppDetailState {
    case success(data: [AppInfoEntity])
    case failed(error: String)
}
