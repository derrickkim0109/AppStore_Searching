//
//  AppDetailSummaryView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/07.
//

import UIKit

final class AppDetailSummaryView: BaseView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private lazy var topUnderlineView = makeDiverView(
        type: .horizontal
    )

    private lazy var bottomUnderlineView = makeDiverView(
        type: .horizontal
    )

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                topUnderlineView,
                horizontalStackView,
                bottomUnderlineView
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()

    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(scrollView)
        scrollView.addSubview(verticalStackView)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(
                equalTo: scrollView.topAnchor),
            verticalStackView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: 10),
            verticalStackView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor,
                constant: -10)
        ])
    }

    func configure(appItem: AppSearchItemModel) {
        setupAppItemInfoView(appItem)
    }

    private func setupAppItemInfoView(_ appItem: AppSearchItemModel) {
        if appItem.averageUserRating > 0 {
            let ratingView = makeRatingView(
                rating: appItem.averageUserRating,
                userRatingCount: appItem.userRatingCount.formattedNumber)
            let ratingVerticalDivider = makeVerticalView()

            [ratingView,
             ratingVerticalDivider]
                .forEach{ horizontalStackView.addArrangedSubview($0) }
        }

        let ageView = makeContentAgeView(appItem.contentAdvisoryRating)

        let genreVerticalDivider = makeVerticalView()
        let genreView = makeGenreView(
            genre: appItem.genres.first ?? "",
            genreImageName: appItem.getGenreImageName()
        )

        let developerInfoVerticalDivider = makeVerticalView()
        let developerInfoView = makeDeveloperInfoView(appItem.sellerName)

        [ageView,
         genreVerticalDivider,
         genreView,
         developerInfoVerticalDivider,
         developerInfoView]
            .forEach{ horizontalStackView.addArrangedSubview($0) }

        if !appItem.languages.isEmpty {
            let verticalDivider = makeVerticalView()
            let languageView = makeLanguageView(appItem.languages)

            [verticalDivider,
             languageView]
                .forEach{ horizontalStackView.addArrangedSubview($0) }
        }
    }

    private func makeRatingView(
        rating: Double,
        userRatingCount: String
    ) -> UIStackView {
        let roundedRating = round(rating * 100) / 100
        let ratingStackView = makeAppItemInfoStackView()
        let titleLabel = makeUILabel(
            text: userRatingCount + "개의 평가",
            font: UIFont.systemFont(
                ofSize: 12,
                weight: .bold
            ),
            textAlignment: .center
        )

        let roundedRatingLabel = makeUILabel(
            text: String(rating.roundedOneDecimal()),
            font: UIFont.systemFont(
                ofSize: 18,
                weight: .black
            ),
            textAlignment: .center
        )

        let starRatingView = StarRatingView()
        starRatingView.updatingViews(roundedRating)
        starRatingView.heightAnchor.constraint(equalToConstant: 15).isActive = true

        titleLabel.setContentHuggingPriority(
            .required,
            for:.vertical
        )
        starRatingView.setContentHuggingPriority(
            .required,
            for:.vertical
        )

        [titleLabel,
         roundedRatingLabel,
         starRatingView]
            .forEach{ ratingStackView.addArrangedSubview($0) }

        return ratingStackView
    }

    private func makeContentAgeView(
        _ age: String
    ) -> UIStackView {
        let ageStackView = makeAppItemInfoStackView()
        let titleLabel = makeUILabel(
            text: "연령",
            font: UIFont.systemFont(
                ofSize: 12,
                weight: .bold
            ),
            textAlignment: .center
        )

        let ageLabel = makeUILabel(
            text: String(age),
            font: UIFont.systemFont(
                ofSize: 18,
                weight: .black
            ),
            textAlignment: .center
        )

        let bottomLabel = makeUILabel(
            text: "세",
            font: UIFont.systemFont(
                ofSize: 13,
                weight: .bold
            ),
            textAlignment: .center
        )

        titleLabel.setContentHuggingPriority(
            .required,
            for:.vertical
        )

        bottomLabel.setContentHuggingPriority(
            .required,
            for:.vertical
        )

        [titleLabel,
         ageLabel,
         bottomLabel]
            .forEach{ ageStackView.addArrangedSubview($0) }

        return ageStackView
    }

    private func makeGenreView(
        genre: String,
        genreImageName: String
    ) -> UIStackView {
        let genreStackView = makeAppItemInfoStackView()
        let titleLabel = makeUILabel(
            text: "카테고리",
            font: UIFont.systemFont(
                ofSize: 12,
                weight: .bold
            ),
            textAlignment: .center
        )

        let genreImageView = makeIconView(
            by: genreImageName
        )

        let bottomLabel = makeUILabel(
            text: genre,
            font: UIFont.systemFont(
                ofSize: 13,
                weight: .bold
            ),
            textAlignment: .center
        )

        titleLabel.setContentHuggingPriority(
            .required,
            for:.vertical
        )

        bottomLabel.setContentHuggingPriority(
            .required,
            for:.vertical
        )

        [titleLabel,
         genreImageView,
         bottomLabel]
            .forEach{ genreStackView.addArrangedSubview($0) }

        return genreStackView
    }

    private func makeDeveloperInfoView(
        _ sellerName: String
    ) -> UIStackView {
        let developerInfoStackView = makeAppItemInfoStackView()
        let titleLabel = makeUILabel(
            text: "개발자",
            font: UIFont.systemFont(
                ofSize: 12,
                weight: .bold
            ),
            textAlignment: .center
        )

        let developerImageView = makeIconView(
            by: "person.crop.square"
        )

        let bottomLabel = makeUILabel(
            text: sellerName,
            font: UIFont.systemFont(
                ofSize: 13,
                weight: .bold
            ),
            textAlignment: .center
        )

        titleLabel.setContentHuggingPriority(
            .required,
            for:.vertical
        )

        bottomLabel.setContentHuggingPriority(
            .required,
            for:.vertical
        )

        [titleLabel,
         developerImageView,
         bottomLabel]
            .forEach{ developerInfoStackView.addArrangedSubview($0) }

        return developerInfoStackView
    }

    private func makeLanguageView(
        _ languages: [AppLanguageModel]
    ) -> UIStackView {
        let languageStackView = makeAppItemInfoStackView()

        let referenceText = languages.count > 1 ?
        "+ \(languages.count - 1)개 언어" : (languages.first?.getKorean() ?? "")

        let titleLabel = makeUILabel(
            text: "언어",
            font: UIFont.systemFont(
                ofSize: 12,
                weight: .bold
            ),
            textAlignment: .center
        )

        let middleLabel = makeUILabel(
            text: languages.first?.rawValue ?? "",
            font: UIFont.systemFont(
                ofSize: 18,
                weight: .black
            ),
            textAlignment: .center
        )

        let bottomLabel = makeUILabel(
            text: referenceText,
            font: UIFont.systemFont(
                ofSize: 13,
                weight: .bold
            ),
            textAlignment: .center
        )

        titleLabel.setContentHuggingPriority(
            .required,
            for:.vertical
        )

        bottomLabel.setContentHuggingPriority(
            .required,
            for:.vertical
        )

        [titleLabel,
         middleLabel,
         bottomLabel]
            .forEach{ languageStackView.addArrangedSubview($0) }

        return languageStackView
    }
}
