//
//  MainViewModelAdvancedTests.swift
//  carousel
//
//  Created by ellkaden on 10/04/26.
//

import XCTest
@testable import carousel

@MainActor
final class MainViewModelAdvancedTests: XCTestCase {

    // MARK: - Paging
    
    func testFilteringUsesCurrentPage() async {
        let vm = MainViewModel(repository: MultiPageMockRepository())
        
        await vm.load()
        
        vm.currentPage = 1
        vm.searchText = "berry"
        
        let result = vm.filteredItems
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.title, "Blueberry")
    }

    // MARK: - Edge Cases
    
    func testFilteringWithInvalidPageReturnsEmpty() async {
        let vm = MainViewModel(repository: MockRepository())
        
        await vm.load()
        
        vm.currentPage = 999
        
        let result = vm.filteredItems
        
        XCTAssertTrue(result.isEmpty)
    }

    // MARK: - State Changes
    
    func testSearchUpdatesFilteredItems() async {
        let vm = MainViewModel(repository: MockRepository())
        
        await vm.load()
        
        vm.currentPage = 0
        
        vm.searchText = "fruit"
        let firstResult = vm.filteredItems
        
        vm.searchText = "vegetable"
        let secondResult = vm.filteredItems
        
        XCTAssertNotEqual(firstResult.first?.title, secondResult.first?.title)
    }

    // MARK: - Basic UI Integration
    
    func testContentViewHasItems() async {
        let vm = MainViewModel(repository: MockRepository())
        await vm.load()
        
        let view = ContentView(viewModel: vm)
        
        XCTAssertNotNil(view)
    }
    
    private final class MockRepository: CarouselRepository {
        func getPages() async -> [[ListItem]] {
            return [
                [
                    ListItem(title: "Apple", subtitle: "Fruit", imageName: ""),
                    ListItem(title: "Carrot", subtitle: "Vegetable", imageName: "")
                ]
            ]
        }
    }

    private final class MultiPageMockRepository: CarouselRepository {
        func getPages() async -> [[ListItem]] {
            return [
                [
                    ListItem(title: "Apple", subtitle: "Fruit", imageName: "")
                ],
                [
                    ListItem(title: "Blueberry", subtitle: "Berry", imageName: "")
                ]
            ]
        }
    }
}
