//
//  ImageCacheManager.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/19.
//

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()

    private var imageRequestSession: URLSession?
    private let urlCache = URLCache(
        memoryCapacity: 20 * 1024 * 1024,
        diskCapacity: 100 * 1024 * 1024,
        diskPath: "ImageDownloadCache")

    func request(
        _ url: URL
    ) async throws -> UIImage {
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: 60
        )

        if let cacheResponse = urlCache.cachedResponse(for: urlRequest),
           let cachedImage = UIImage(data: cacheResponse.data) {
            return cachedImage
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200 ..< 300).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponseError
            }

            guard let image = UIImage(data: data) else {
                throw NetworkError.unknownError
            }

            let cacheResponse = CachedURLResponse(
                response: httpResponse,
                data: data
            )

            DispatchQueue.main.async { [weak self] in
                self?.urlCache.storeCachedResponse(cacheResponse, for: urlRequest)
            }

            return image
        } catch {
            throw error
        }
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
