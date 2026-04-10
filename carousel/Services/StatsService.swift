//
//  StatsService.swift
//  carousel
//
//  Created by ellkaden on 09/04/26.
//

import Foundation

protocol StatsProviding {
    func topCharacters(from items: [ListItem], limit: Int) -> [(Character, Int)]
}

final class StatsService: StatsProviding {

    func topCharacters(from items: [ListItem], limit: Int = 3) -> [(Character, Int)] {
        let text = items
            .flatMap { [$0.title, $0.subtitle] }
            .joined()
            .lowercased()

        let letters = text.filter { $0.isLetter }

        let counts = Dictionary(grouping: letters, by: { $0 })
            .mapValues { $0.count }

        return counts
            .sorted { lhs, rhs in
                if lhs.value == rhs.value {
                    return lhs.key < rhs.key
                }
                return lhs.value > rhs.value
            }
            .prefix(limit)
            .map { $0 }
    }
}
