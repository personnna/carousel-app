//
//  ContentViewSnapshotTests.swift
//  carousel
//
//  Created by ellkaden on 10/04/26.
//

import XCTest
import SwiftUI
@testable import carousel

@MainActor
final class ContentViewSnapshotTests: XCTestCase {

    func testContentViewRenders() async throws {
        
        let viewModel = MainViewModel(repository: MockRepository())
        await viewModel.load()
        
        let view = ContentView(viewModel: viewModel)
        
        let hosting = UIHostingController(rootView: view)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = hosting
        window.makeKeyAndVisible()
        
        hosting.loadViewIfNeeded()
        await Task.yield()
        
        hosting.view.layoutIfNeeded()
        
        let image = hosting.view.asImage()
        
        XCTAssertNotNil(image)
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


private extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}
