//
//  ContentView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedCategory: Category = .tvShows
    @State private var showSettings: Bool = false
    @AppStorage(AppStorageKeys.isPinLockEnabled.rawValue) private var isPinLockEnabled: Bool = false
    @AppStorage(AppStorageKeys.isFaceIDEnabled.rawValue) private var isFaceIDEnabled: Bool = false
    
    var body: some View {
        LockView(lockType: isFaceIDEnabled ? .both : .number, isEnabled: isPinLockEnabled) {
            NavigationStack {
                Group {
                    switch selectedCategory {
                    case .tvShows:
                        TVGuideView()
                    case .people:
                        PeopleView()
                    case .favorites:
                        FavoritesView()
                    }
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        PickerTitleView(selectedCategory: $selectedCategory)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showSettings.toggle()
                        }) {
                            Image(systemName: "gearshape.fill")
                                .imageScale(.large)
                        }
                    }
                }
                .fullScreenCover(isPresented: $showSettings) {
                    SettingsView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
