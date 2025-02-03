//
//  ImageCacheManagerTests.swift
//  FetchTakeHomeTests
//
//  Created by Cameron Moss on 2/3/25.
//

import XCTest
@testable import FetchTakeHome

class ImageCacheManagerTests: XCTestCase {
    var cacheManager: ImageCacheManager!
    
    override func setUp() {
        super.setUp()
        cacheManager = ImageCacheManager()
    }
    
    override func tearDown() {
        cacheManager = nil
        super.tearDown()
    }
    
    func testMemoryCacheStoresAndRetrievesImage() {
        let image = UIImage(systemName: "star")!
        let key = "testImageKey"
        
        cacheManager.setImage(image: image, for: key)
        let cachedImage = cacheManager.getImage(for: key)
        
        XCTAssertNotNil(cachedImage)
        XCTAssertEqual(cachedImage?.pngData(), image.pngData())
    }
    
    func testDiskCacheStoresAndRetrievesImage() {
        let image = UIImage(systemName: "star")!
        let key = "testDiskImageKey"
        
        cacheManager.setImage(image: image, for: key)
        let retrievedImage = cacheManager.getImage(for: key)
        
        XCTAssertNotNil(retrievedImage)
        XCTAssertEqual(retrievedImage?.pngData(), image.pngData())
    }
}
