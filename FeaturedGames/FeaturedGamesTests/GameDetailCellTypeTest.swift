//
//  GameDetailCellTypeTest.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 07/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import XCTest
@testable import FeaturedGames

class GameDetailCellTypeTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitWithRow() {
        XCTAssertEqual(GameDetailCellType(row: 0), .image)
        XCTAssertEqual(GameDetailCellType(row: 1), .name)
        XCTAssertEqual(GameDetailCellType(row: 2), .infos)
        XCTAssertEqual(GameDetailCellType(row: 5), .infos)
    }
    
    func testHeight() {
        XCTAssertEqual(GameDetailCellType.name.height, 68)
        XCTAssertEqual(GameDetailCellType.infos.height, 100)
    }
    
    func testAllValues() {
        XCTAssertEqual(GameDetailCellType.allValues.count, 3)
        XCTAssertEqual(GameDetailCellType.allValues.first, .image)
        XCTAssertEqual(GameDetailCellType.allValues.last, .infos)
    }
    
}
