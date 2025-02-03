//
//  MockURLProtocol.swift
//  FetchTakeHomeTests
//
//  Created by Cameron Moss on 2/3/25.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var testData: Data?
    static var response: URLResponse?
    static var error: Error?
    static var scenario: TestScenario = .success

    enum TestScenario {
        case success
        case emptyResponse
        case malformedResponse
        case networkError
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        switch MockURLProtocol.scenario {
        case .success:
            client?.urlProtocol(self, didLoad: MockURLProtocol.testData ?? Data())
            client?.urlProtocol(self, didReceive: MockURLProtocol.response!, cacheStoragePolicy: .notAllowed)

        case .emptyResponse:
            client?.urlProtocol(self, didLoad: Data())

        case .malformedResponse:
            let invalidData = "Invalid Image Data".data(using: .utf8)!
            client?.urlProtocol(self, didLoad: invalidData)

        case .networkError:
            client?.urlProtocol(self, didFailWithError: URLError(.notConnectedToInternet))
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}

extension URLSession {
    static let mock: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }()
}
