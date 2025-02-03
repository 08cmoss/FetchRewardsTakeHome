//
//  CachedAsyncImage.swift
//  FetchTakeHome
//
//  Created by Cameron Moss on 2/3/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    @StateObject private var loader = ImageLoader()
    let urlString: String
    
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .shadow(radius: 4)
            } else {
                ProgressView()
                    .task {
                        await loader.loadImage(from: urlString)
                    }
            }
        }
    }
}

