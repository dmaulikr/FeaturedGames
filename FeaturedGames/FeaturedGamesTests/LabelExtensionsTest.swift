//
//  LabelExtensionsTest.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 05/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import XCTest
import UIKit
@testable import FeaturedGames

class LabelExtensionsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLabelStyleAttributes() {
        XCTAssertEqual(LabelStyle.navigation.attributes.font, UIFont.systemFont(ofSize: 24, weight: UIFontWeightSemibold))
        XCTAssertEqual(LabelStyle.navigation.attributes.textColor, Colors.primary.color)
        
        XCTAssertEqual(LabelStyle.gameName.attributes.font, UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold))
        XCTAssertEqual(LabelStyle.gameName.attributes.textColor, Colors.primary.color)
        
        XCTAssertEqual(LabelStyle.gameRankingPositionTag.attributes.font, UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold))
        XCTAssertEqual(LabelStyle.gameRankingPositionTag.attributes.textColor, Colors.white.color)
    }
    
    func testColors() {
        XCTAssertEqual(Colors.primary.color, UIColor(red: 219/255, green: 81/255, blue: 73/255, alpha: 1.0))
        XCTAssertEqual(Colors.positionTag.color, UIColor(red: 254/255, green: 210/255, blue: 0/255, alpha: 1.0))
        XCTAssertEqual(Colors.white.color, .white)
        XCTAssertEqual(Colors.black.color, .black)
    }
    
    func testFillLabel() {
        let testLabel = UILabel()
        testLabel.fill(with: "testing fill", and: .gameName)
        
        XCTAssertEqual(testLabel.text, "testing fill")
        XCTAssertEqual(testLabel.font, UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold))
        XCTAssertEqual(testLabel.textColor, UIColor(red: 219/255, green: 81/255, blue: 73/255, alpha: 1.0))
    }
}
