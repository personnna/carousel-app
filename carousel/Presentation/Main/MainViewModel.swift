//
//  MainViewModel.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import Combine
import Foundation

@MainActor
final class MainViewModel: ObservableObject {
    
    private let repository: CarouselRepository
    
    @Published var pages: [[ListItem]] = []
    @Published var currentPage: Int = 0
    @Published var searchText: String = ""
    @Published private(set) var debouncedSearchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: CarouselRepository) {
        self.repository = repository
        setupBindings()
    }
    
    func load() async {
        guard pages.isEmpty else { return }
        pages = await repository.getPages()
    }
    
    private func setupBindings() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] value in
                self?.debouncedSearchText = value
            }
            .store(in: &cancellables)
    }
    
    var filteredItems: [ListItem] {
        guard pages.indices.contains(currentPage) else { return [] }
        
        let items = pages[currentPage]
        let query = searchText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        if query.isEmpty { return items }
        
        return items.filter {
            $0.searchableText.contains(query)
        }
    }
}
