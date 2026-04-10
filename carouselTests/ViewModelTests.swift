//
//  ViewModelTests.swift
//  carousel
//
//  Created by ellkaden on 09/04/26.
//

import XCTest
@testable import carousel

@MainActor
final class ViewModelTests: XCTestCase {

    // MARK: - Filtering
    
    func testFilteringMatchesSubtitle() async {
        let vm = MainViewModel(repository: MockRepository())
        
        await vm.load()
        vm.currentPage = 0
        vm.searchText = "fruit"

        let result = vm.filteredItems

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.title, "Apple")
    }

    func testFilteringMatchesTitle() async {
        let vm = MainViewModel(repository: MockRepository())
        
        await vm.load()
        vm.currentPage = 0
        vm.searchText = "carrot"

        let result = vm.filteredItems

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.title, "Carrot")
    }

    func testFilteringReturnsEmptyForUnknownQuery() async {
        let vm = MainViewModel(repository: MockRepository())
        
        await vm.load()
        vm.currentPage = 0
        vm.searchText = "zzz"

        let result = vm.filteredItems

        XCTAssertTrue(result.isEmpty)
    }

    func testFilteringIsCaseInsensitive() async {
        let vm = MainViewModel(repository: MockRepository())
        
        await vm.load()
        vm.currentPage = 0
        vm.searchText = "FRUIT"

        let result = vm.filteredItems

        XCTAssertEqual(result.count, 1)
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
}
