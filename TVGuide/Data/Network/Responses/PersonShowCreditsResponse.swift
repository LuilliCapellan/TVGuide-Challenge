//
//  PersonShowCreditsResponse.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/4/25.
//

struct PersonShowCreditsResponse: Decodable {
    let castCredits: [TVShowCredit]

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }

    enum EmbeddedKeys: String, CodingKey {
        case castCredits = "castcredits"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let embeddedContainer = try? container.nestedContainer(keyedBy: EmbeddedKeys.self, forKey: .embedded) {
            self.castCredits = (try? embeddedContainer.decode([TVShowCredit].self, forKey: .castCredits)) ?? []
        } else {
            self.castCredits = []
        }
    }
}
