//
//  RecipeListViewModelTests.swift
//  FetchTakeHomeTests
//
//  Created by Cameron Moss on 2/3/25.
//

import XCTest
@testable import FetchTakeHome

@MainActor
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

    func testFetchRecipesSuccess() async {
        mockService.scenario = .success
        await viewModel.getRecipes()

        XCTAssertEqual(viewModel.recipes.count, 2)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchRecipesEmptyResponse() async {
        mockService.scenario = .emptyResponse
        await viewModel.getRecipes()

        XCTAssertEqual(viewModel.recipes.count, 0)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchRecipesMalformedResponse() async {
        mockService.scenario = .malformedResponse
        await viewModel.getRecipes()

        XCTAssertEqual(viewModel.recipes.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Failed to fetch recipes. Try again later.")
    }

    func testFetchRecipesNetworkError() async {
        mockService.scenario = .networkError
        await viewModel.getRecipes()

        XCTAssertEqual(viewModel.recipes.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Failed to fetch recipes. Try again later.")
    }
}
