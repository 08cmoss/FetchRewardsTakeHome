//
//  ImageLoaderTests.swift
//  FetchTakeHomeTests
//
//  Created by Cameron Moss on 2/3/25.
//

import XCTest
@testable import FetchTakeHome

@MainActor
class ImageLoaderTests: XCTestCase {
    var loader: ImageLoader!
    var testImageData: Data!

    override func setUp() {
        super.setUp()
        loader = ImageLoader(session: .mock)
        testImageData = UIImage(systemName: "star")!.jpegData(compressionQuality: 0.8)
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

    func testLoadImageSuccess() async {
        MockURLProtocol.scenario = .success
        MockURLProtocol.testData = testImageData

        await loader.loadImage(from: "https://test.com/image.jpg")

        XCTAssertNotNil(loader.image)
        XCTAssertEqual(loader.image?.pngData(), UIImage(data: testImageData)?.pngData())
    }

    func testLoadImageEmptyResponse() async {
        MockURLProtocol.scenario = .emptyResponse

        await loader.loadImage(from: "https://test.com/image.jpg")

        XCTAssertNil(loader.image)
    }

    func testLoadImageMalformedResponse() async {
        MockURLProtocol.scenario = .malformedResponse

        await loader.loadImage(from: "https://test.com/image.jpg")

        XCTAssertNil(loader.image)
    }

    func testLoadImageNetworkError() async {
        MockURLProtocol.scenario = .networkError

        await loader.loadImage(from: "https://test.com/image.jpg")

        XCTAssertNil(loader.image)
    }
}
