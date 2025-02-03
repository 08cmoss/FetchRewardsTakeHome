//
//  APIService.swift
//  FetchTakeHome
//
//  Created by Cameron Moss on 2/3/25.
//

import Foundation

enum Routes {
    case getRecipes
    case getRecipesMalformed
    case getRecipesEmpty
    
    var path: String {
        switch self {
        case .getRecipes:
            return "/recipes.json"
        case .getRecipesMalformed:
            return "/recipes-malformed.json"
        case .getRecipesEmpty:
            return "/recipes-empty.json"
        }
    }
}

class APIService {
    static let shared = APIService()
    
    let baseURL: URL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net")!
    
    func getRecipes(for route: Routes) async throws -> RecipeDTO {
        guard let url = URL(string: "\(baseURL)\(route.path)") else {
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let recipeDTO = try JSONDecoder().decode(RecipeDTO.self, from: data)
            return recipeDTO
        } catch {
            print("Error fetching data: \(error)")
            throw error
        }
    }
}
