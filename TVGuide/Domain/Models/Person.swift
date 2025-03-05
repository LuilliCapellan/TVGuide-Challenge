//
//  Person.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import Foundation

struct Person: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let country: Country?
    let image: ImageURLs?

    struct Country: Codable, Equatable {
        let name: String?
    }

    struct ImageURLs: Codable, Equatable {
        let medium: URL?
        let original: URL?
    }

    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
