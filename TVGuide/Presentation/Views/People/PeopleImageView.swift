//
//  PeopleImageView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/4/25.
//

import SwiftUI

struct PeopleImageView: View {
    let imageURL: URL?
    
    var body: some View {
        if let imageURL {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                case .failure, .empty:
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                        .background(Color(UIColor.systemGray4))
                        .clipShape(Circle())
                @unknown default:
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
            }
        } else {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
                .background(Color(UIColor.systemGray4))
                .clipShape(Circle())
        }
    }
}
