//
//  ViewModelTests.swift
//  carousel
//
//  Created by ellkaden on 09/04/26.
//

import XCTest
@testable import carousel

final class ViewModelTests: XCTestCase {

    func testFilteringIncludesSubtitle() {
        let vm = MainViewModel(dataProvider: MockDataProvider())

        vm.searchText = "fruit"

        let result = vm.filteredItems

        XCTAssertTrue(result.contains { $0.subtitle.lowercased().contains("fruit") })
    }
}

private final class MockDataProvider: DataProviding {
    func loadPages() -> [[ListItem]] {
        return [[
            ListItem(title: "Apple", subtitle: "Fruit", imageName: ""),
            ListItem(title: "Car", subtitle: "Vehicle", imageName: "")
        ]]
    }
}
