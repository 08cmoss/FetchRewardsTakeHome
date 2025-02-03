//
//  ImageLoader.swift
//  FetchTakeHome
//
//  Created by Cameron Moss on 2/3/25.
//

import SwiftUI

@MainActor
class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private let cache = ImageCacheManager.shared

    func loadImage(from urlString: String) async {
        if let cachedImage = cache.getImage(for: urlString) {
            self.image = cachedImage
            return
        }

        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let fetchedImage = UIImage(data: data) else { return }

            cache.setImage(image: fetchedImage, for: urlString)

            self.image = fetchedImage
        } catch {
            print("Failed to load image: \(error)")
        }
    }
}
