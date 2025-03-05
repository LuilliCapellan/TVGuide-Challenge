//
//  EpisodeDetailImageView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/4/25.
//

import SwiftUI

struct EpisodeDetailImageView: View {
    let imageURL: String?

    var body: some View {
        GeometryReader { geometry in
            let maxWidth = geometry.size.width
            let aspectRatio: CGFloat = 642 / 360
            let height = maxWidth / aspectRatio

            VStack {
                if let imageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable()
                                .scaledToFit()
                                .frame(maxWidth: maxWidth)
                                .cornerRadius(12)

                        case .failure, .empty:
                            placeholderView(width: maxWidth, height: height)

                        @unknown default:
                            ProgressView()
                                .frame(width: maxWidth, height: height)
                        }
                    }
                } else {
                    placeholderView(width: maxWidth, height: height)
                }
            }
            .frame(width: maxWidth, height: height)
        }
        .frame(height: 200)
        .padding()
    }

    @ViewBuilder
    private func placeholderView(width: CGFloat, height: CGFloat) -> some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
            .foregroundColor(.gray)
            .background(Color(.systemGray5))
            .cornerRadius(8)
    }
}
