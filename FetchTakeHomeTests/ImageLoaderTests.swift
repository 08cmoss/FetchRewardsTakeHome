//
//  ImageLoaderTests.swift
//  FetchTakeHomeTests
//
//  Created by Cameron Moss on 2/3/25.
//

import XCTest
@testable import FetchTakeHome

class ImageLoaderTests: XCTestCase {
    var loader: ImageLoader!
    var testImageData: Data!

    override func setUp() {
        super.setUp()
        loader = ImageLoader()
        testImageData = UIImage(systemName: "star")!.jpegData(compressionQuality: 0.8)

        MockURLProtocol.testData = testImageData
        MockURLProtocol.response = HTTPURLResponse(url: URL(string: "https://test.com/image.jpg")!,
                                                   statusCode: 200,
                                                   httpVersion: nil,
                                                   headerFields: nil)
    }

    override func tearDown() {
        loader = nil
        testImageData = nil
        super.tearDown()
    }

    func testLoadImageFromNetwork() async {
        await loader.loadImage(from: "https://test.com/image.jpg")

        XCTAssertNotNil(loader.image)
        XCTAssertEqual(loader.image?.pngData(), UIImage(data: testImageData)?.pngData())
    }

    func testLoadImageFromCache() async {
        let testURL = "https://test.com/image.jpg"
        let testImage = UIImage(systemName: "star")!
        ImageCacheManager.shared.setImage(image: testImage, for: testURL)

        await loader.loadImage(from: testURL)

        XCTAssertNotNil(loader.image)
        XCTAssertEqual(loader.image?.pngData(), testImage.pngData())
    }
}
