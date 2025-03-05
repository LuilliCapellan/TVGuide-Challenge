//
//  TVShowCredit.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/4/25.
//

struct TVShowCredit: Decodable {
    let show: TVShow

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }

    enum EmbeddedKeys: String, CodingKey {
        case show
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // ✅ Extract `_embedded.show`
        let embeddedContainer = try container.nestedContainer(keyedBy: EmbeddedKeys.self, forKey: .embedded)
        self.show = try embeddedContainer.decode(TVShow.self, forKey: .show)
    }
}
