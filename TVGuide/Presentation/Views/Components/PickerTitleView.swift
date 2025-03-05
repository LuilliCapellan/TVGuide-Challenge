//
//  PickerTitleView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import SwiftUI

struct PickerTitleView: View {
    @Binding var selectedCategory: Category

    var body: some View {
        Menu {
            ForEach(Category.allCases) { category in
                Button(action: {
                    selectedCategory = category
                }) {
                    Text(category.rawValue)
                }
            }
        } label: {
            HStack {
                Text(selectedCategory.rawValue)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Image(systemName: "chevron.down")
                    .font(.caption)
            }
        }
    }
}
