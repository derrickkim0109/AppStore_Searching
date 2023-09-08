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
}
