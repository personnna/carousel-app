//
//  MainViewModel.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import Combine

@MainActor
final class MainViewModel: ObservableObject {
    
    private let repository: CarouselRepository
    
    // MARK: - State
    
    @Published var pages: [[ListItem]] = []
    @Published var currentPage: Int = 0
    @Published var searchText: String = ""
    
    // MARK: - Computed
    
    var filteredItems: [ListItem] {
        guard pages.indices.contains(currentPage) else { return [] }
        
        let items = pages[currentPage]
        
        if searchText.isEmpty { return items }
        
        return items.filter {
            ($0.title + " " + $0.subtitle)
                .lowercased()
                .contains(searchText.lowercased())
        }
    }
    
    // MARK: - Init
    
    init(repository: CarouselRepository) {
        self.repository = repository
    }
    
    // MARK: - Load
    
    func load() async {
        guard pages.isEmpty else { return }
        pages = await repository.getPages()
    }
}
