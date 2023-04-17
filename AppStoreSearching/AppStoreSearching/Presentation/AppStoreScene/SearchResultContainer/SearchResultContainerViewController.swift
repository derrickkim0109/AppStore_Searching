//
//  ResultsContainerViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

enum SearchType {
    case partial
    case final
}

protocol SearchResultViewControllerDelegate: AnyObject { }

final class SearchResultContainerViewController: ContentStateViewController {
    private let suggestedTermsTableViewController: SuggestedTermsTableViewController
    private let appsInfoListViewController: AppsInfoListViewController
    
    var didSelect: (String) -> Void = { _ in }
    weak var coordinator: SearchResultViewControllerDelegate?

    init(
        suggestedTermsTableViewController: SuggestedTermsTableViewController,
        appsInfoListViewController: AppsInfoListViewController) {
            self.suggestedTermsTableViewController = suggestedTermsTableViewController
            self.appsInfoListViewController = appsInfoListViewController

            super.init(
                nibName: nil,
                bundle: nil)
        }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
        view.backgroundColor = .systemBackground
        suggestedTermsTableViewController.didSelect = didSelect
    }

    func handle(
        term: String,
        searchType: SearchType) {
            switch searchType {
            case .partial:
                suggestedTermsTableViewController.searchedTerm = term
                transition(to: .render(suggestedTermsTableViewController))
            case .final:
                appsInfoListViewController.didSearch(term: term)
                transition(to: .render(appsInfoListViewController))
            }
        }
}
