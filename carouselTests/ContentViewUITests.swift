//
//  ContentViewUITests.swift
//  carousel
//
//  Created by ellkaden on 10/04/26.
//

import XCTest
import SwiftUI
@testable import carousel

@MainActor
final class ContentViewUITests: XCTestCase {

    // MARK: - Rendering
    
    func testContentViewRendersWithData() async {
        let vm = MainViewModel(repository: MockRepository())
        await vm.load()
        
        let view = ContentView(viewModel: vm)
        let hosting = UIHostingController(rootView: view)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = hosting
        window.makeKeyAndVisible()
        
        hosting.loadViewIfNeeded()
        await Task.yield()
        
        XCTAssertFalse(vm.pages.isEmpty)
    }

    // MARK: - Search Interaction
    
    func testSearchAffectsDisplayedItems() async {
        let vm = MainViewModel(repository: MockRepository())
        await vm.load()
        
        vm.currentPage = 0
        
        vm.searchText = "fruit"
        let fruitItems = vm.filteredItems
        
        vm.searchText = "vegetable"
        let vegetableItems = vm.filteredItems
        
        XCTAssertNotEqual(
            fruitItems.first?.title,
            vegetableItems.first?.title
        )
    }

    // MARK: - Paging Interaction
    
    func testChangingPageUpdatesVisibleItems() async {
        let vm = MainViewModel(repository: MultiPageMockRepository())
        await vm.load()
        
        vm.currentPage = 0
        let firstPageItems = vm.filteredItems
        
        vm.currentPage = 1
        let secondPageItems = vm.filteredItems
        
        XCTAssertNotEqual(
            firstPageItems.first?.title,
            secondPageItems.first?.title
        )
    }

    // MARK: - Layout
    
    func testContentViewHasLayout() async {
        let vm = MainViewModel(repository: MockRepository())
        await vm.load()
        
        let view = ContentView(viewModel: vm)
        let hosting = UIHostingController(rootView: view)
        
        hosting.loadViewIfNeeded()
        await Task.yield()
        
        let size = hosting.view.intrinsicContentSize
        
        XCTAssertNotEqual(size, .zero)
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
