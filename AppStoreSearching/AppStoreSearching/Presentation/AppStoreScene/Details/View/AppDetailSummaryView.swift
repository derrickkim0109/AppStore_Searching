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

        [topUnderlineView,
         scrollView,
         bottomUnderlineView]
            .forEach { addSubview($0) }

        scrollView.addSubview(horizontalStackView)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            heightAnchor.constraint(
                equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            topUnderlineView.topAnchor.constraint(
                equalTo: topAnchor),
            topUnderlineView.bottomAnchor.constraint(
                equalTo: scrollView.topAnchor,
                constant: -10),
            topUnderlineView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            topUnderlineView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(
                equalTo: bottomUnderlineView.topAnchor,
                constant: -10),
            scrollView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(
                equalTo: scrollView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor),

            horizontalStackView.heightAnchor.constraint(
                equalTo: scrollView.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            bottomUnderlineView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            bottomUnderlineView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            bottomUnderlineView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])
    }

    func configure(appItem: AppSearchItemModel) {
        setupAppItemInfoView(appItem)
    }

    private func setupAppItemInfoView(_ appItem: AppSearchItemModel) {
        let ratingView = makeRatingView(
            rating: appItem.averageUserRating,
            userRatingCount: appItem.userRatingCount.formattedNumber)

        let ageVerticalDivider = makeVerticalView()
        let ageView = makeContentAgeView(appItem.contentAdvisoryRating)

        let genreVerticalDivider = makeVerticalView()
        let genreView = makeGenreView(
            genre: appItem.genres.first ?? "",
            genreImageName: appItem.getGenreImageName()
        )

        let developerInfoVerticalDivider = makeVerticalView()
        let developerInfoView = makeDeveloperInfoView(appItem.sellerName)

        [ratingView,
         ageVerticalDivider,
         ageView,
         genreVerticalDivider,
         genreView,
         developerInfoVerticalDivider,
         developerInfoView]
            .forEach{ horizontalStackView.addArrangedSubview($0) }

        if !appItem.languages.isEmpty {
            let verticalDivider = makeVerticalView()
            let languageView = makeLangaugeView(appItem.languages)

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
            )
        )

        let roundedRatingLabel = makeUILabel(
            text: String(rating.roundedOneDecimal()),
            font: UIFont.systemFont(
                ofSize: 18,
                weight: .black
            )
        )

        let starRatingView = StarRatingView()
        starRatingView.updatingViews(roundedRating)
        starRatingView.heightAnchor.constraint(equalToConstant: 20).isActive = true

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
            )
        )

        let ageLabel = makeUILabel(
            text: String(age),
            font: UIFont.systemFont(
                ofSize: 18,
                weight: .black
            )
        )

        let bottomLabel = makeUILabel(
            text: "세",
            font: UIFont.systemFont(
                ofSize: 13,
                weight: .bold
            )
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
            )
        )

        let genreImageView = makeIconView(
            by: genreImageName
        )

        let bottomLabel = makeUILabel(
            text: genre,
            font: UIFont.systemFont(
                ofSize: 13,
                weight: .bold
            )
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
            )
        )

        let developerImageView = makeIconView(
            by: "person.crop.square"
        )

        let bottomLabel = makeUILabel(
            text: sellerName,
            font: UIFont.systemFont(
                ofSize: 13,
                weight: .bold
            )
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

    private func makeLangaugeView(
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
            )
        )

        let middleLabel = makeUILabel(
            text: languages.first?.rawValue ?? "",
            font: UIFont.systemFont(
                ofSize: 18,
                weight: .black
            )
        )

        let bottomLabel = makeUILabel(
            text: referenceText,
            font: UIFont.systemFont(
                ofSize: 13,
                weight: .bold
            )
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
