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
        XCTAssertEqual(LabelStyle.navigation.attributes.font, UIFont.systemFont(ofSize: 20, weight: UIFontWeightSemibold))
        XCTAssertEqual(LabelStyle.navigation.attributes.textColor, Colors.white.color)
        
        XCTAssertEqual(LabelStyle.gameName.attributes.font, UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold))
        XCTAssertEqual(LabelStyle.gameName.attributes.textColor, Colors.gameName.color)
        
        XCTAssertEqual(LabelStyle.gameRankingPositionTag.attributes.font, UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold))
        XCTAssertEqual(LabelStyle.gameRankingPositionTag.attributes.textColor, Colors.white.color)
    }
    
    func testColors() {
        XCTAssertEqual(Colors.primary.color, UIColor(red: 31/255, green: 145/255, blue: 203/255, alpha: 1.0))
        XCTAssertEqual(Colors.gameName.color, UIColor(red: 20/255, green: 101/255, blue: 150/255, alpha: 1.0))
        XCTAssertEqual(Colors.gameRankingPositionTag.color, UIColor(red: 48/255, green: 173/255, blue: 234/255, alpha: 1.0))
        XCTAssertEqual(Colors.white.color, .white)
        XCTAssertEqual(Colors.black.color, .black)
    }
    
    func testFillLabel() {
        let testLabel = UILabel()
        testLabel.fill(with: "testing fill", and: .gameName)
        
        XCTAssertEqual(testLabel.text, "testing fill")
        XCTAssertEqual(testLabel.font, UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold))
        XCTAssertEqual(testLabel.textColor, UIColor(red: 20/255, green: 101/255, blue: 150/255, alpha: 1.0))
    }
}
