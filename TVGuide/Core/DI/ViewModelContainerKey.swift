//
//  ViewModelContainerKey.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import SwiftUI

private struct ViewModelContainerKey: EnvironmentKey {
    static let defaultValue = ViewModelContainer(repositories: RepositoryContainer())
}

extension EnvironmentValues {
    var viewModels: ViewModelContainer {
        get { self[ViewModelContainerKey.self] }
        set { self[ViewModelContainerKey.self] = newValue }
    }
}
