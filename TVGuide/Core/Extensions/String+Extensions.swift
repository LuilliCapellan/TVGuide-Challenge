//
//  String+Extensions.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import Foundation

extension String {
    func removingHTMLTags() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
