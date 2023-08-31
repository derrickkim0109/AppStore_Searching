//
//  CachedAsyncImageView.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/22.
//

import UIKit

final class CachedAsyncImageView: BaseView {
    private let rectangleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    private var image: UIImage?
    private var error: NetworkError?

    override func setupDefault() {
        super.setupDefault()

        backgroundColor = .black
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(rectangleView)
        rectangleView.addSubview(containerView)
        containerView.addSubview(imageView)
        addSubview(activityIndicator)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            rectangleView.topAnchor.constraint(
                equalTo: topAnchor),
            rectangleView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            rectangleView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            rectangleView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(
                equalTo: rectangleView.topAnchor),
            containerView.bottomAnchor.constraint(
                equalTo: rectangleView.bottomAnchor),
            containerView.leadingAnchor.constraint(
                equalTo: rectangleView.leadingAnchor),
            containerView.trailingAnchor.constraint(
                equalTo: rectangleView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(
                equalTo: containerView.topAnchor),
            imageView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor),
            imageView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(
                equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(
                equalTo: containerView.centerYAnchor)
        ])
    }

    func configure(_ cachedImageInfo: CachedImageInfo?) {
        containerView.layer.cornerRadius = cachedImageInfo?.cornerRadius ?? 0.0
        rectangleView.layer.cornerRadius = cachedImageInfo?.cornerRadius ?? 0.0

        if let image = image {
            imageView.image = image
        } else if error != nil {
            imageView.image = UIImage(systemName: "x.circle")
        } else {
            getCacheImage(by: cachedImageInfo?.urlStr ?? "")
            activityIndicator.startAnimating()
        }
    }

    func setupBoarderWidth(_ width: Double) {
        rectangleView.layer.borderColor = UIColor.lightGray.cgColor
        rectangleView.layer.borderWidth = width
    }

    private func getCacheImage(by url: String) {
        guard let url = URL(string: url) else {
            return
        }

        ImageCacheManager.shared.requestImageURL(url) { [weak self] image in
            self?.activityIndicator.stopAnimating()
            self?.imageView.image = image
        } failure: { error in
            self.error = error
        }
    }
}

