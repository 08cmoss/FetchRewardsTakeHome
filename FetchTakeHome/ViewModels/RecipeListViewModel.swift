//
//  RecipeListViewModel.swift
//  FetchTakeHome
//
//  Created by Cameron Moss on 2/3/25.
//

import Foundation

@MainActor
class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?

    private var apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }

    func getRecipes() async {
        do {
            let responseDTO = try await apiService.getRecipes(for: .getRecipes)
            recipes = responseDTO.recipes.sorted { $0.cuisine < $1.cuisine }
        } catch {
            errorMessage = "Failed to fetch recipes. Try again later."
            print("Error: \(error)")
        }
    }
}
