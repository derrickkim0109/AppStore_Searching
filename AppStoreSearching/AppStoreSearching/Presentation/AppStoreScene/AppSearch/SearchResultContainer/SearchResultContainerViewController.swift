//
//  SearchResultContainerViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class SearchResultContainerViewController: ContentStateViewController {
    private let recentKeywordListViewController: RecentKeywordListViewController
    private let appsInfoListViewController: AppSearchResultListViewController
    
    init(
        recentKeywordListViewController: RecentKeywordListViewController,
        appsInfoListViewController: AppSearchResultListViewController
    ) {
        self.recentKeywordListViewController = recentKeywordListViewController
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
    }

    func handle(
        keyword: String,
        resultState: ResultState
    ) {
        switch resultState {
        case .searching:
            transition(to: .render(recentKeywordListViewController))

        case .hasResult:
            transition(to: .render(appsInfoListViewController))

        case .noResult, .none:
            break
        }
    }
}
