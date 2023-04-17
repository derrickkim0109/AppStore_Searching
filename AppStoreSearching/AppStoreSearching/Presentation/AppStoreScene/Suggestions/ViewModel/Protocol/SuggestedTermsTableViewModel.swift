//
//  SuggestedTermsTableViewModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

protocol SuggestedTermsTableViewModelInput {
    func filter(_ searchTerm: String)
}

protocol SuggestedTermsTableViewModelOutput {
    var filteredNames: [String] { get }
}

protocol SuggestedTermsTableViewModel: SuggestedTermsTableViewModelInput,
                                       SuggestedTermsTableViewModelOutput {}
