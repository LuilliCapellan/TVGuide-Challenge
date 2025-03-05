//
//  SearchBarView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchQuery: String
    @FocusState.Binding var isFocused: Bool // ✅ Track keyboard focus

    var body: some View {
        HStack {
            TextField("Search TV Shows...", text: $searchQuery)
                .focused($isFocused) // ✅ Ensure immediate focus
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)

            if !searchQuery.isEmpty {
                Button(action: {
                    searchQuery = ""
                    isFocused = false // ✅ Dismiss keyboard on clear
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
    }
}
