//
//  DataProvider.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import Foundation

protocol DataProviding {
    func loadPages() -> [[ListItem]]
}

final class DataProvider: DataProviding {
    
    private let source: DataSourceType
    
    init(source: DataSourceType = .mock) {
        self.source = source
    }

    func loadPages() -> [[ListItem]] {
        switch source {
        case .mock:
            return loadMockPages()
        case .localJSON:
            return loadFromJSON()
        }
    }
}

private extension DataProvider {

    func loadMockPages() -> [[ListItem]] {
        [
            [
                ListItem(title: "Apple", subtitle: "Fruit", imageName: "apple"),
                ListItem(title: "Banana", subtitle: "Fruit", imageName: "banana")
            ],
            [
                ListItem(title: "Orange", subtitle: "Citrus", imageName: "orange"),
                ListItem(title: "Blueberry", subtitle: "Berry", imageName: "blueberry")
            ],
            [
                ListItem(title: "Strawberry", subtitle: "Berry", imageName: "strawberry"),
                ListItem(title: "Carrot", subtitle: "Vegetable", imageName: "carrot"),
                ListItem(title: "Salmon", subtitle: "Fish", imageName: "salmon"),
                ListItem(title: "Milk", subtitle: "Dairy", imageName: "milk"),
                ListItem(title: "Bread", subtitle: "Bakery", imageName: "bread"),
                ListItem(title: "Chicken", subtitle: "Meat", imageName: "chicken")
            ],
            [
                ListItem(title: "Apple", subtitle: "Fruit", imageName: "apple"),
                ListItem(title: "Orange", subtitle: "Citrus", imageName: "orange")
            ],
            [
                ListItem(title: "Banana", subtitle: "Fruit", imageName: "banana"),
                ListItem(title: "Strawberry", subtitle: "Berry", imageName: "strawberry")
            ]
        ]
    }

    func loadFromJSON() -> [[ListItem]] {
        return loadMockPages()
    }
}
