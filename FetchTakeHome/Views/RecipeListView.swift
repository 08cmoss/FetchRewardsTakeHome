//
//  RecipeListView.swift
//  FetchTakeHome
//
//  Created by Cameron Moss on 2/3/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel(apiService: APIService.shared)
    @State private var navPath: [Recipe] = []

    var body: some View {
        NavigationStack(path: $navPath) {
            List(viewModel.recipes, id: \.uuid) { recipe in
                RecipeView(recipe: recipe)
            }
            .navigationTitle("Recipes")
            .refreshable {
                await viewModel.getRecipes()
            }
            .onAppear {
                Task {
                    await viewModel.getRecipes()
                }
            }
            .overlay {
                if viewModel.recipes.isEmpty {
                    ContentUnavailableView("No recipes found",
                                           systemImage: "fork.knife.circle.fill",
                                           description: Text("Please try again later"))
                }
            }
        }
        .alert(viewModel.errorMessage ?? "",
               isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("Dismiss", role: .cancel) { viewModel.errorMessage = nil }
        }
    }
}

#Preview("RecipeListView") {
    RecipeListView()
}
