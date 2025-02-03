//
//  RecipeView.swift
//  FetchTakeHome
//
//  Created by Cameron Moss on 2/3/25.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            CachedAsyncImage(urlString: recipe.photoURLSmall ?? "")
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.subheadline)
                    .bold()
                Text(recipe.cuisine)
                    .font(.callout)
            }
        }
    }
}
