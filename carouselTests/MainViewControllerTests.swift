//
//  MainViewControllerTests.swift
//  carousel
//
//  Created by ellkaden on 10/04/26.
//

import XCTest
@testable import carousel

@MainActor
final class MainViewControllerTests: XCTestCase {
    
    func testChangingPageUpdatesTableView() async {
        let vm = MainViewModel(repository: MultiPageMockRepository())
        await vm.load()
        
        let vc = MainViewController(viewModel: vm)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        vc.loadViewIfNeeded()
        
        // меняем страницу
        vm.currentPage = 1
        
        // даём Combine отработать
        await Task.yield()
        
        let rows = vc.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(rows, 1)
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
