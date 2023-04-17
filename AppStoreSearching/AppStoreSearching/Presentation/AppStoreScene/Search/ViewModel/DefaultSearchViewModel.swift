//
//  DefaultSearchViewModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import Foundation

final class DefaultSearchViewModel: SearchViewModel {
    var recentKeywords: [String] = []
    var appsInfo: [AppInfoEntity] = []
    var error: String = ""
    
    init() { }
    
    private func fetchRecentTerm() {
        guard let history = UserDefaults.standard.stringArray(
            forKey: Const.searchTerm) else {
            return
        }
        
        recentKeywords = history
    }

    private enum Const {
        static let searchTerm = "searchTerm"
        static let zero = 0
        static let ten = 10
    }
}

extension DefaultSearchViewModel {
    func viewDidLoad() {
        fetchRecentTerm()
    }
    
    func save(_ term: String) {
        if let row = recentKeywords.firstIndex(of: term) {
            recentKeywords.remove(at: row)
        }
        
        if recentKeywords.count >= Const.ten {
            recentKeywords.removeLast()
        }
        
        recentKeywords.insert(
            term,
            at: Const.zero)
        
        UserDefaults.standard.set(
            recentKeywords,
            forKey: Const.searchTerm)
    }
}
