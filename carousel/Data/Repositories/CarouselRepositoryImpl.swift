//
//  CarouselRepositoryImpl.swift
//  carousel
//
//  Created by ellkaden on 10/04/26.
//

final class CarouselRepositoryImpl: CarouselRepository {
    func getPages() async -> [[ListItem]] {
        [
            [
                ListItem(title: "Apple", subtitle: "Fruit", imageName: "apple"),
                ListItem(title: "Banana", subtitle: "Fruit", imageName: "banana")
            ],
            [
                ListItem(title: "Orange", subtitle: "Citrus", imageName: "orange"),
                ListItem(title: "Blueberry", subtitle: "Berry", imageName: "blueberry")
            ]
        ]
    }
}
