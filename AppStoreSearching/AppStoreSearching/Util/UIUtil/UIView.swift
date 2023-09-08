//
//  UIView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/18.
//

import UIKit

extension UIView {
    func setupCenter(in view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        let layoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            leftAnchor.constraint(equalTo: layoutGuide.leftAnchor),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            rightAnchor.constraint(equalTo: layoutGuide.rightAnchor)
        ])
    }
    
    func makeAppItemInfoStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10

        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(
                greaterThanOrEqualToConstant: 80),
            stackView.widthAnchor.constraint(
                lessThanOrEqualToConstant: 120)
        ])

        return stackView
    }

    func makeScreenshotImageView(
        by url: String,
        cornerRadius: CGFloat
    ) -> CachedAsyncImageView {
        let cachedInfo = CachedImageInfo(
            urlStr: url,
            cornerRadius: cornerRadius
        )

        let imageView = CachedAsyncImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.configure(cachedInfo)
        imageView.setupBoarder(0.2)

        return imageView
    }

    func makeIconView(
        by imageName: String
    ) -> UIView {
        let containerView = UIView()

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: imageName)
        imageView.tintColor = .lightGray
        
        containerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(
                equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(
                equalTo: containerView.centerYAnchor),
            imageView.widthAnchor.constraint(
                equalTo: imageView.heightAnchor),
            imageView.widthAnchor.constraint(
                equalToConstant: 30)
        ])

        return containerView
    }

    func makeStarRatingImageView(
       _ rating: Double
   ) -> StarRatingImageView {
       let ratingImageView = StarRatingImageView(
           frame: CGRect(
               x: 0,
               y: 0,
               width: 13,
               height: 20
           )
       )
       return ratingImageView
   }

    func makeUILabel(
        text: String,
        font: UIFont
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textAlignment = .center
        return label
    }

    func makeVerticalView() -> UIView {
        let containerView = UIView()
        let verticalDivider = makeDiverView(type: .vertical)

        containerView.addSubview(verticalDivider)

        NSLayoutConstraint.activate([
            verticalDivider.centerXAnchor.constraint(
                equalTo: containerView.centerXAnchor),
            verticalDivider.centerYAnchor.constraint(
                equalTo: containerView.centerYAnchor)
        ])

        return containerView
    }

    func makeDiverView(
        type: DividerType
    ) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray

        if type == .horizontal {
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(
                    equalToConstant: 0.3)
            ])
        } else {
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(
                    equalToConstant: 30),
                view.widthAnchor.constraint(
                    equalToConstant: 0.5)
            ])
        }

        return view
    }
}
