//
//  TVShow.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import Foundation

struct TVShow: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let schedule: Schedule?
    let summary: String?
    let image: ImageURLs?
    let genres: [String]
    let embedded: Embedded?

    enum CodingKeys: String, CodingKey {
        case id, name, schedule, summary, image, genres
        case embedded = "_embedded"
    }

    struct ImageURLs: Codable, Hashable {
        let medium: URL?
        let original: URL?
    }

    struct Schedule: Codable, Hashable {
        let time: String
        let days: [String]
    }

    struct Embedded: Codable, Hashable {
        let cast: [CastMember]?
        
        enum CodingKeys: String, CodingKey {
            case cast = "cast"
        }
    }

    struct CastMember: Codable, Hashable {
        let person: Person

        func hash(into hasher: inout Hasher) {
            hasher.combine(person.id)
        }

        static func == (lhs: CastMember, rhs: CastMember) -> Bool {
            return lhs.person.id == rhs.person.id
        }
    }

    static func == (lhs: TVShow, rhs: TVShow) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
