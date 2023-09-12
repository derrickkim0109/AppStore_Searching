//
//  ExpandableLabelView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/09.
//

import UIKit

final class ExpandableLabelView: BaseView {
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                contentLabel,
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

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()

    private let seeMoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "더보기"
        label.textColor = .systemBlue
        label.backgroundColor = .black
        label.textAlignment = .right
        return label
    }()

    private lazy var bottomUnderlineView = makeDiverView(
        type: .horizontal
    )

    private var isExpanded : Bool = false {
        didSet {
            seeMoreLabel.isHidden = isExpanded

            if isExpanded {
                contentLabel.numberOfLines = 0
            }
        }
    }

    override func setupDefault() {
        super.setupDefault()

        let tabGestureCancelReportButton = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapSeeMore(_:))
        )

        seeMoreLabel.addGestureRecognizer(tabGestureCancelReportButton)
        seeMoreLabel.isUserInteractionEnabled = true
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(rootStackView)
        addSubview(seeMoreLabel)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(
                equalTo: topAnchor),
            rootStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            rootStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            rootStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            bottomUnderlineView.widthAnchor.constraint(
                equalTo: rootStackView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            seeMoreLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -15),
            seeMoreLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])
    }

    func configure(text: String) {
        if !text.contains("\n") {
            seeMoreLabel.isHidden = true
        }
        contentLabel.text = text
    }

    @objc private func didTapSeeMore(_ sender: UIGestureRecognizer) {
        self.isExpanded = true
    }
}
