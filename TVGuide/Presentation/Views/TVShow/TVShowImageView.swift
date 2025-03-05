//
//  TVShowImageView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import SwiftUI

struct TVShowImageView: View {
    let imageURL: URL?
    
    init(imageString: String?) {
        if let imageString {
            self.imageURL = URL(string: imageString)
        } else {
            imageURL = nil
        }
    }
    
    init(imageURL: URL?) {
        self.imageURL = imageURL
    }
    
    var body: some View {
        if let imageURL {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 120)
                        .cornerRadius(8)
                case .failure, .empty:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 120)
                        .foregroundColor(.gray)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                @unknown default:
                    ProgressView()
                        .frame(width: 80, height: 120)
                }
            }
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 120)
                .foregroundColor(.gray)
                .background(Color(.systemGray5))
                .cornerRadius(8)
        }
    }
}
