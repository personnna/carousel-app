//
//  GetCarouselUseCase.swift
//  carousel
//
//  Created by ellkaden on 10/04/26.
//

final class GetCarouselUseCase {
    
    private let repository: CarouselRepository
    
    init(repository: CarouselRepository) {
        self.repository = repository
    }
    
    func execute() async -> [[ListItem]] {
        await repository.getPages()
    }
}
