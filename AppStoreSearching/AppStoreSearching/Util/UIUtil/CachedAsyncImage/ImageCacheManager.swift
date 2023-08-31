//
//  ImageCacheManager.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/19.
//

import UIKit

final class ImageCacheManager {
    typealias SuccessHandler = (_ image: UIImage) -> Void
    typealias FailureHandler = (_ error: NetworkError) -> Void

    static let shared = ImageCacheManager()

    private var imageRequestSession: URLSession?
    private let urlCache = URLCache(
        memoryCapacity: 20 * 1024 * 1024,
        diskCapacity: 100 * 1024 * 1024,
        diskPath: "ImageDownloadCache")

    func requestImageURL(
        _ url: URL,
        success: @escaping SuccessHandler,
        failure: @escaping FailureHandler
    ) {
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: 60
        )

        if let cacheResponse = urlCache.cachedResponse(for: urlRequest),
           let cachedImage = UIImage.init(data: cacheResponse.data)  {
            DispatchQueue.main.async {
                success(cachedImage)
            }
            return
        }

        let task = imageRequestSession?.dataTask(with: url) {
            [weak self]
            (data,
             response,
             error) in
            guard error == nil else {
                failure(.invalidResponseError)
                return
            }

            guard let response = response as? HTTPURLResponse,
                  case 200 ..< 300 = response.statusCode else {
                failure(.unknownError)
                return
            }

            guard let data = data else {
                return
            }

            let cacheResponse = CachedURLResponse(
                response: response,
                data: data)

            self?.urlCache.storeCachedResponse(
                cacheResponse,
                for: urlRequest)

            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    success(image)
                }
            }
        }
        task?.resume()
    }

    private init() {
        imageRequestSession = URLSession(
            configuration: makeURLSessionConfiguration(),
            delegate: nil,
            delegateQueue: nil
        )
    }

    private func makeURLSessionConfiguration() -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfiguration.urlCache = urlCache
        return sessionConfiguration
    }
}
