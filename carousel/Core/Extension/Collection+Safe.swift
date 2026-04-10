//
//  Collection+Safe.swift
//  carousel
//
//  Created by ellkaden on 09/04/26.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
