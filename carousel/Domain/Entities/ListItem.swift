//
//  ListItem.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import Foundation

struct ListItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageName: String
}

extension ListItem {
    var searchableText: String {
        "\(title) \(subtitle)".lowercased()
    }
}
