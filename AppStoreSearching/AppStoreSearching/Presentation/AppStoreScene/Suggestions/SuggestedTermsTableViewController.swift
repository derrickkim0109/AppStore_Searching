//
//  SuggestedTermsTableViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

final class SuggestedTermsTableViewController: UIViewController {
    private let viewModel: SuggestedTermsTableViewModel
    var didSelect: (String) -> Void = { _ in }
    
    var searchedTerm = String() {
        didSet {
            viewModel.filter(searchedTerm)

            DispatchQueue.main.async { [weak self] in
                self?.suggestedTermsTableView.reloadData()
            }
        }
    }

    private let suggestedTermsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SuggestedTermTableViewCell.self)
        tableView.tableHeaderView = UIView(
            frame: CGRect(
                x: Const.zero,
                y: Const.zero,
                width: tableView.bounds.size.width,
                height: CGFloat.leastNormalMagnitude))
        return tableView
    }()
    
    init(viewModel: SuggestedTermsTableViewModel) {
        self.viewModel = viewModel
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func bind() {
        view.backgroundColor = .systemBackground
        view.addSubview(suggestedTermsTableView)
        setupTableView()
        configureLayouts()
    }
    
    private func setupTableView() {
        suggestedTermsTableView.delegate = self
        suggestedTermsTableView.dataSource = self
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            suggestedTermsTableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            suggestedTermsTableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            suggestedTermsTableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            suggestedTermsTableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private enum Const {
        static let zero = 0.0
    }
}

extension SuggestedTermsTableViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return viewModel.filteredNames.count
        }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: SuggestedTermTableViewCell = tableView.dequeueReusableCell(
                forIndexPath: indexPath)
            cell.selectionStyle = .none
            cell.configure(term: viewModel.filteredNames[indexPath.row])
            return cell
        }
}

extension SuggestedTermsTableViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            didSelect(viewModel.filteredNames[indexPath.row])
            tableView.deselectRow(
                at: indexPath,
                animated: false)
        }
}
