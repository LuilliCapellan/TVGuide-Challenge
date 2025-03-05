//
//  TVGuideApp.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import SwiftUI

@main
struct TVGuideApp: App {
    @StateObject private var viewModelContainer: ViewModelContainer

    init() {
        _viewModelContainer = StateObject(wrappedValue: ViewModelContainer(repositories: RepositoryContainer()))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.viewModels, viewModelContainer)
        }
    }
}
