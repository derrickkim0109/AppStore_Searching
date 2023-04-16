//
//  UIImageView+Extensions.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/03/19.
//

import UIKit

extension UIImageView {
    func setImageUrl(_ url: String) async throws {
        let imageCacheManager = ImageCacheManager.shared
        let bag = AnyCancelTaskBag()

        Task {
            let cachedKey = NSString(string: url)
            if let cachedImage = imageCacheManager.object(forKey: cachedKey) {
                DispatchQueue.main.async {
                    self.image = cachedImage
                }
                return
            }

            guard let url = URL(string: url) else {
                return
            }

            do {
                let (data, response) = try await URLSession.shared.data(
                    for: URLRequest(url: url))

                if let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode != 200 {
                    throw NetworkError.error(
                        statusCode: httpResponse.statusCode,
                        data: data)
                }

                if let image = UIImage(data: data) {
                    imageCacheManager.setObject(
                        image,
                        forKey: cachedKey)
                    Task {
                        await MainActor.run() {
                            self.image = image
                        }
                    }.store(in: bag)
                }
            } catch {
                self.image = UIImage()
            }
        }.store(in: bag)
    }
}
