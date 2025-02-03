//
//  MockAPIService.swift
//  FetchTakeHomeTests
//
//  Created by Cameron Moss on 2/3/25.
//

import XCTest
@testable import FetchTakeHome

class MockAPIService: APIService {
    enum TestScenario {
        case success
        case emptyResponse
        case malformedResponse
        case networkError
    }

    var scenario: TestScenario = .success

    override func getRecipes(for route: Routes) async throws -> RecipeDTO {
        switch scenario {
        case .success:
            return RecipeDTO(recipes: [
                Recipe(uuid: UUID(), cuisine: "Italian", name: "Beef Stroganoff"),
                Recipe(uuid: UUID(), cuisine: "Italian", name: "Chicken Parmesan")
            ])
            
        case .emptyResponse:
            return RecipeDTO(recipes: [])

        case .malformedResponse:
            throw NSError(domain: "MockMalformedData", code: 2, userInfo: nil)
            
        case .networkError:
            throw URLError(.notConnectedToInternet)
        }
    }
}
