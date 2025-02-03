//
//  ImageCacheManager.swift
//  FetchTakeHome
//
//  Created by Cameron Moss on 2/3/25.
//

import SwiftUI

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()
    
    func getImage(for key: String) -> UIImage? {
        if let cachedImage = cache.object(forKey: key as NSString) {
            return cachedImage
        }
        
        if let diskImage = loadImageFromDisk(for: key) {
            cache.setObject(diskImage, forKey: key as NSString)
            return diskImage
        }
        
        return nil
    }
    
    func setImage(image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
        saveImageToDisk(image: image, for: key)
    }
    
    private func getFileURL(for key: String) -> URL? {
        let fileManager = FileManager.default
        guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return cacheDirectory.appendingPathComponent(key)
    }
    
    private func saveImageToDisk(image: UIImage, for key: String) {
        guard let fileURL = getFileURL(for: key),
        let data = image.jpegData(compressionQuality: 0.8) else { // Convert to JPEG format
            return
        }
        
        try? data.write(to: fileURL, options: .atomic)
    }
    
    private func loadImageFromDisk(for key: String) -> UIImage? {
        guard let fileURL = getFileURL(for: key),
              let data = try? Data(contentsOf: fileURL),
              let image = UIImage(data: data) else {
            return nil
        }
        
        return image
    }
}
