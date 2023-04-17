//
//  SearchViewModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

protocol SearchViewModelInput {
    func save(_ term: String)
    func viewDidLoad()
}

protocol SearchViewModelOutput {
    var recentKeywords: [String] { get }
}

protocol SearchViewModel: SearchViewModelInput,
                          SearchViewModelOutput {}
