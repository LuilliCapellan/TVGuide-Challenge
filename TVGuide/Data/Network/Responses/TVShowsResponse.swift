//
//  TVShowsResponse.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import Foundation

struct TVShowsResponse: Codable {
    let page: Int
    let results: [TVShow]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results, totalPages = "total_pages", totalResults = "total_results"
    }
}
