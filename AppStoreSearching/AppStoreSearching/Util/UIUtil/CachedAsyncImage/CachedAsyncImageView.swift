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
            activityIndicator.startAnimating()

            Task { [weak self] in
                do {
                    guard let urlStr = cachedImageInfo?.urlStr,
                          let cachedImage = try await self?.getCacheImage(by: urlStr) else {
                        return
                    }

                    await MainActor.run() {
                        self?.imageView.image = cachedImage
                        self?.activityIndicator.stopAnimating()
                    }
                } catch (let error) {
                    if let networkError = error as? NetworkError {
                        // NetworkError 타입인 경우에 대한 처리
                        self?.error = networkError
                    } else {
                        // 다른 에러 타입인 경우에 대한 처리
                        // 예: 기본 에러 메시지 표시 등
                        self?.error = .unknownError
                    }
                }
            }.store(in: bag)
        }
    }

    func setupBoarder(_ width: Double) {
        rectangleView.layer.borderColor = UIColor.lightGray.cgColor
        rectangleView.layer.borderWidth = width
    }

    func remove() {
        imageView.image = nil
    }

    private func getCacheImage(
        by url: String
    ) async throws -> UIImage {
        guard let url = URL(string: url) else {
            throw NetworkError.makeURLError
        }

        do {
            let image = try await ImageCacheManager.shared.request(url)
            return image
        } catch (let error) {
            throw error
        }
    }
}

