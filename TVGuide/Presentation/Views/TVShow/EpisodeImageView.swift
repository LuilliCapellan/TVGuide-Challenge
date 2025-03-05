//
//  EpisodeImageView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/4/25.
//

import SwiftUI

struct EpisodeImageView: View {
    let imageURL: String?
    
    var body: some View {
        if let imageURL {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 60)
                        .cornerRadius(8)
                case .failure, .empty:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 60)
                        .foregroundColor(.gray)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                @unknown default:
                    ProgressView()
                        .frame(width: 100, height: 60)
                }
            }
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 60)
                .foregroundColor(.gray)
                .background(Color(.systemGray5))
                .cornerRadius(8)
        }
    }
}


