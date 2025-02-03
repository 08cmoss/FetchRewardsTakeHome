//
//  MockAPIService.swift
//  FetchTakeHomeTests
//
//  Created by Cameron Moss on 2/3/25.
//

import XCTest
@testable import FetchTakeHome

class MockAPIService: APIService {
    var shouldReturnError = false
    
    override func getRecipes(for route: Routes) async throws -> RecipeDTO {
        if shouldReturnError {
            throw NSError(domain: "MockError", code: 1, userInfo: nil)
        }
        return RecipeDTO(recipes: [
            Recipe(uuid: UUID(), cuisine: "Italian", name: "Beef Stroganoff"),
            Recipe(uuid: UUID(), cuisine: "Italian", name: "Chicken Parmesan")
        ])
    }
}
