//
//  Episode.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import Foundation

struct Episode: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let airdate: String?
    let airtime: String?
    let runtime: Int?
    let rating: Rating?
    let image: ImageURL?
    let summary: String?
    
    struct Rating: Codable, Equatable, Hashable {
        let average: Double?
    }

    struct ImageURL: Codable, Equatable, Hashable {
        let medium: String?
        let original: String?
    }

    enum CodingKeys: String, CodingKey {
        case id, name, season, number, airdate, airtime, runtime, rating, image, summary
    }

    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.season == rhs.season &&
               lhs.number == rhs.number &&
               lhs.airdate == rhs.airdate &&
               lhs.airtime == rhs.airtime &&
               lhs.runtime == rhs.runtime &&
               lhs.rating == rhs.rating &&
               lhs.image == rhs.image &&
               lhs.summary == rhs.summary
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
