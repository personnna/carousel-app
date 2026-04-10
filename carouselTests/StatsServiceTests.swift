//
//  StatsServiceTests.swift
//  carousel
//
//  Created by ellkaden on 09/04/26.
//

import XCTest
@testable import carousel

final class StatsServiceTests: XCTestCase {

    private var service: StatsService!

    override func setUp() {
        super.setUp()
        service = StatsService()
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testTopCharacters_countsTitleAndSubtitle_andIgnoresNonLetters() {
        let items = [
            ListItem(title: "Apple", subtitle: "Fruit", imageName: ""),
            ListItem(title: "Banana", subtitle: "Yellow!", imageName: "")
        ]

        let result = service.topCharacters(from: items, limit: 3)

        let dict = Dictionary(uniqueKeysWithValues: result)

        XCTAssertEqual(dict["a"], 4)
        XCTAssertEqual(dict["l"], 3)
        XCTAssertEqual(dict["e"], 3)

        XCTAssertEqual(result.count, 3)
    }
}
