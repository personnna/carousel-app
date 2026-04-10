//
//  CarouselRepository.swift
//  carousel
//
//  Created by ellkaden on 10/04/26.
//

protocol CarouselRepository {
    func getPages() async -> [[ListItem]]
}
