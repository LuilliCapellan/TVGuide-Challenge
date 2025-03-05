//
//  PersonImageView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/4/25.
//

import SwiftUI

struct PersonImageView: View {
    let imageURL: URL?
    
    var body: some View {
        if let imageURL {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                case .failure, .empty:
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .foregroundColor(.gray)
                        .background(Color(UIColor.systemGray4))
                        .clipShape(Circle())
                @unknown default:
                    ProgressView()
                        .frame(width: 200, height: 200)
                }
            }
        } else {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .foregroundColor(.gray)
                .background(Color(UIColor.systemGray4))
                .clipShape(Circle())
        }
    }
}
