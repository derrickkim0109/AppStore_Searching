//
//  AppDetailViewController.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/21.
//

import UIKit

protocol AppDetailViewControllerDelegate: AnyObject {}

final class AppDetailViewController: UIViewController {
    private let viewModel: AppDetailViewModel
    private let bag = AnyCancelTaskBag()
    weak var coordinator: AppDetailViewControllerDelegate?

    private var appDescription: String = ""
    private var screentshotsURL: [String] = [] {
        didSet {
            screentshotsURL.removeFirst()
            screenshotCollectionView.reloadData()
        }
    }

    private lazy var rootScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let iconImageView: IconImageView = {
        let imageView = IconImageView()
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appNameLabel,
                                                       appArtistNameLabel,
                                                       fetchButtonContainer])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: 20,
            weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    private let appArtistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: 13,
            weight: .light)
        label.textColor = UIColor.lightGray
        return label
    }()

    private lazy var fetchButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fetchButton)
        return view
    }()

    private let fetchButton: FetchButton = {
        let button = FetchButton()
        button.setTitleColor(
            UIColor.white,
            for: .normal)
        button.backgroundColor = UIColor.systemBlue
        return button
    }()

    private let settingButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "ellipsis.circle.fill")
        
        return imageView
    }()

    private lazy var screenshotCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: screenCollectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(AppDetailScreenshotCollectionViewCell.self)
        return collectionView
    }()

    private lazy var screenCollectionViewLayout: UICollectionViewLayout = {
        return UICollectionViewCompositionalLayout { [weak self]
            section,
            _ -> NSCollectionLayoutSection? in
            guard let layout = self?.createScreenShotItemSection() else {
                return nil
            }
            
            return layout
        }
    }()

    init(viewModel: AppDetailViewModel) {
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
        didSearch()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func bind() {
        view.backgroundColor = .systemBackground
        screenshotCollectionView.dataSource = self
        screenshotCollectionView.delegate = self

        setupViews()
        configureLayouts()
        setupSettingButtonAction()
    }

    private func setupViews() {
        view.addSubview(rootScrollView)

        [iconImageView,
         infoStackView,
         fetchButton,
         settingButtonImageView,
         screenshotCollectionView].forEach{ rootScrollView.addSubview($0) }
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            rootScrollView.topAnchor.constraint(
                equalTo: view.topAnchor),
            rootScrollView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            rootScrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            rootScrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(
                equalTo: rootScrollView.topAnchor,
                constant: 20),
            iconImageView.leadingAnchor.constraint(
                equalTo: rootScrollView.leadingAnchor,
                constant: 20),
            iconImageView.widthAnchor.constraint(
                equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(
                equalTo: iconImageView.topAnchor),
            infoStackView.bottomAnchor.constraint(
                equalTo: iconImageView.bottomAnchor),
            infoStackView.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: 10),
            infoStackView.trailingAnchor.constraint(
                equalTo: rootScrollView.trailingAnchor,
                constant: -20)
        ])

        NSLayoutConstraint.activate([
            fetchButton.topAnchor.constraint(
                equalTo: fetchButtonContainer.topAnchor),
            fetchButton.bottomAnchor.constraint(
                equalTo: fetchButtonContainer.bottomAnchor),
            fetchButton.leadingAnchor.constraint(
                equalTo: fetchButtonContainer.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            settingButtonImageView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20),
            settingButtonImageView.centerYAnchor.constraint(
                equalTo: fetchButtonContainer.centerYAnchor),
            settingButtonImageView.widthAnchor.constraint(
                equalTo: settingButtonImageView.heightAnchor),
            settingButtonImageView.widthAnchor.constraint(
                equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            screenshotCollectionView.topAnchor.constraint(
                equalTo: iconImageView.bottomAnchor,
                constant: 18),
            screenshotCollectionView.bottomAnchor.constraint(
                equalTo: rootScrollView.bottomAnchor),
            screenshotCollectionView.leadingAnchor.constraint(
                equalTo: rootScrollView.leadingAnchor,
                constant: 18),
            screenshotCollectionView.trailingAnchor.constraint(
                equalTo: rootScrollView.trailingAnchor,
                constant: -18),
            screenshotCollectionView.heightAnchor.constraint(
                equalToConstant: 550),
            screenshotCollectionView.centerXAnchor.constraint(
                equalTo: rootScrollView.centerXAnchor)
        ])

//        appNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
//        appNameLabel.setContentHuggingPriority(.required, for: .vertical)
//
//        appArtistNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        appArtistNameLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }

    private func createScreenShotItemSection() -> NSCollectionLayoutSection {
        let sectionMargin: CGFloat = 0

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(
            top: sectionMargin,
            leading: sectionMargin,
            bottom: sectionMargin,
            trailing: sectionMargin)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(260),
            heightDimension: .estimated(500))

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])

        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(
            top: sectionMargin,
            leading: sectionMargin,
            bottom: sectionMargin,
            trailing: sectionMargin)

        return section
    }

    private func setupImageCaching(
        _ imageView: UIImageView,
        from imageURL: String) async {
            do {
                try await imageView.setImageUrl(imageURL)
            } catch (let error) {
                await AlertControllerBulider.Builder()
                    .setMessag(error.localizedDescription)
                    .setConfrimText("확인")
                    .build()
                    .present()
            }
        }

    private func updateUI(_ appInfo: AppInfoEntity) {
        Task { [weak self] in
            guard let `self` = self else {
                return
            }

            await self.setupImageCaching(
                self.iconImageView,
                from: appInfo.icon)
        }.store(in: bag)

        DispatchQueue.main.async { [weak self] in
            self?.appNameLabel.wrap(appInfo.name)
            self?.appArtistNameLabel.text = appInfo.artistName
        }
    }

    private func setupSettingButtonAction() {
        let tabGestureRefreshButton = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapSettingButton(_:)))

        settingButtonImageView.addGestureRecognizer(tabGestureRefreshButton)
        settingButtonImageView.isUserInteractionEnabled = true
    }

    private func didSearch() {
        Task {
            await viewModel.load()

            guard let state = viewModel.state else {
                return
            }

            switch state {
            case .success(let data):
                guard let entity = data.first else {
                    return
                }

                updateUI(entity)

                let screenshots = entity.screenshots
                screentshotsURL = screenshots

                appDescription = entity.description
            case .failed(let errorMessage):
                await AlertControllerBulider.Builder()
                    .setTitle("알림")
                    .setMessag(errorMessage)
                    .setConfrimText("확인")
                    .build()
                    .present()
            }
        }.store(in: bag)
    }

    private func showAppDescriptionViewController(_ appDescription: String) {
        let viewController = UINavigationController(
            rootViewController: AppDescriptionViewController(appDescription: appDescription))
        viewController.modalPresentationStyle = .popover
        present(viewController, animated: true)
    }

    @objc private func didTapSettingButton(
        _ sender: UITapGestureRecognizer) {
            showAppDescriptionViewController(appDescription)
        }
}

extension AppDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return screentshotsURL.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AppDetailScreenshotCollectionViewCell = collectionView.dequeueReusableCell(
            forIndexPath: indexPath)

            cell.configure(screentshotsURL[indexPath.row])

            return cell
    }
}

extension AppDetailViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: 260,
            height: collectionView.frame.height)
    }
}
