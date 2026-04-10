//
//  MainViewControllerSnapshotTests.swift
//  carousel
//
//  Created by ellkaden on 10/04/26.
//

import XCTest
@testable import carousel

@MainActor
final class MainViewControllerSnapshotTests: XCTestCase {

    @MainActor
    func testMainViewControllerSnapshot() async throws {
        
        let vc = MainViewController(
            viewModel: MainViewModel(repository: MockRepository())
        )
        
        let nav = UINavigationController(rootViewController: vc)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        
        // даём lifecycle пройти
        vc.loadViewIfNeeded()
        await Task.yield()
        
        nav.view.layoutIfNeeded()
        
        // snapshot
        let image = nav.view.asImage()
        
        XCTAssertNotNil(image)
    }
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

private extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}
