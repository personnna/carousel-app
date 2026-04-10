//
//  Array+Safe.swift
//  carousel
//
//  Created by ellkaden on 09/04/26.
//

extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
