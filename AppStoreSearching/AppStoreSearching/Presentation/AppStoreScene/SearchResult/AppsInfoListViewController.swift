//
//  AppsInfoListViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

protocol AppsInfoListViewControllerDelegate: AnyObject {
    func showDetailViewController(
        at viewController: UIViewController,
        of id: Int)
}

final class AppsInfoListViewController: UIViewController {
    private let viewModel: AppsInfoListViewModel
    private let bag = AnyCancelTaskBag()
    weak var coordinator: AppsInfoListViewControllerDelegate?

    private var appsInfo: [AppInfoEntity] = [] {
        didSet {
            DispatchQueue.main.async {
                self.appsInfoTableView.reloadData()
            }
        }
    }

    private let appsInfoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AppsInfoListTableViewCell.self)
        tableView.separatorStyle = .none
        return tableView
    }()

    private let searchedResultEmptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Const.warning
        label.isHidden = true

        label.font = UIFont.systemFont(
            ofSize: 16,
            weight: .medium)
        return label
    }()

    init(viewModel: AppsInfoListViewModel) {
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

    private func bind() {
        view.backgroundColor = .systemBackground
        view.addSubview(appsInfoTableView)
        view.addSubview(searchedResultEmptyLabel)
        setupTableView()
        configureLayouts()
    }

    private func setupTableView() {
        appsInfoTableView.delegate = self
        appsInfoTableView.dataSource = self
    }

    private func setupEmptyLabel() {
        if case .success(let data) = viewModel.state,
           data.isEmpty {
            searchedResultEmptyLabel.isHidden = false
        } else {
            searchedResultEmptyLabel.isHidden = true
        }
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            appsInfoTableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            appsInfoTableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            appsInfoTableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            appsInfoTableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            searchedResultEmptyLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            searchedResultEmptyLabel.centerYAnchor.constraint(
                equalTo: view.centerYAnchor)
        ])
    }

    func didSearch(term: String) {
        Task { [weak self] in
            await self?.viewModel.didSearch(term)
            self?.setupEmptyLabel()

            guard let state = self?.viewModel.state else {
                return
            }

            switch state {
            case .success(let data):
                self?.appsInfo = data
            case .failed(let errorMessage):
                await AlertControllerBulider.Builder()
                    .setTitle(Const.title)
                    .setMessag(errorMessage)
                    .setConfrimText(Const.confirm)
                    .build()
                    .present()
            }
        }.store(in: bag)
    }

    private enum Const {
        static let title = "알림"
        static let confirm = "확인"
        static let warning = "검색 결과가 없습니다."
        static let threeHundredSixty = 360.0
    }
}

extension AppsInfoListViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return appsInfo.count
        }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat {
            return Const.threeHundredSixty
        }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: AppsInfoListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(appInfo: appsInfo[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
}

extension AppsInfoListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(
                at: indexPath,
                animated: false)
            coordinator?.showDetailViewController(
                at: self,
                of: appsInfo[indexPath.row].id)
        }
}
