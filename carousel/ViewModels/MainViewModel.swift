//
//  MainViewModel.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import Combine
import Foundation

final class MainViewModel: ObservableObject {
        
    private let dataProvider: DataProviding

    @Published var pages: [[ListItem]] = []
    @Published var currentPage: Int = 0
    @Published var searchText: String = ""
    @Published private(set) var debouncedSearchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataProvider: DataProviding = DataProvider()) {
        self.dataProvider = dataProvider
        loadData()
        setupBindings()
    }

    private func loadData() {
        pages = dataProvider.loadPages()
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
        let query = debouncedSearchText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !query.isEmpty else {
            return pages[safe: currentPage] ?? []
        }

        return pages[safe: currentPage]?.filter { item in
            item.title.lowercased().contains(query) ||
            item.subtitle.lowercased().contains(query)
        } ?? []
    }
}
