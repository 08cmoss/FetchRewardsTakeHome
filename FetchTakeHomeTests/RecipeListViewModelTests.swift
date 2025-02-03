//
//  RecipeListViewModelTests.swift
//  FetchTakeHomeTests
//
//  Created by Cameron Moss on 2/3/25.
//

import XCTest
@testable import FetchTakeHome

class RecipeListViewModelTests: XCTestCase {
    var viewModel: RecipeListViewModel!
    var mockService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
        viewModel = RecipeListViewModel(apiService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testGetRecipesSuccess() async {
        await viewModel.getRecipes()
        
        XCTAssertEqual(viewModel.recipes.count, 2)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testGetRecipesFailure() async {
        mockService.shouldReturnError = true
        await viewModel.getRecipes()
        
        XCTAssertEqual(viewModel.recipes.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Failed to fetch recipes. Try again later.")
    }
    
}
