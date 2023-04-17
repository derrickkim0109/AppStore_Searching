//
//  DefaultSuggestedTermsTableViewModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/20.
//

import Foundation

final class DefaultSuggestedTermsTableViewModel: SuggestedTermsTableViewModel {
    private var terms: [String] = []
    
    var filteredNames: [String] = []
    
    init() { }
    
    private func fetchTerms() {
        guard let searchedTerms = UserDefaults.standard.stringArray(
            forKey: Const.searchTerm) else {
            return
        }
        
        terms = searchedTerms
    }
    
    private func hasPrefix(_ prefix: String) -> [String] {
        fetchTerms()
        
        let names = terms.filter ({ $0.hasCaseInsensitivePrefix(prefix) })
        return names
    }
    
    private enum Const {
        static let empty = ""
        static let searchTerm = "searchTerm"
    }
}

extension DefaultSuggestedTermsTableViewModel {
    func viewDidLoad() {

    }
    
    func filter(_ searchTerm: String) {
        filteredNames = hasPrefix(searchTerm)
    }
}
