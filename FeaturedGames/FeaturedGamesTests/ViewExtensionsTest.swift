//
//  ViewExtensionsTest.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 05/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import XCTest
import UIKit
@testable import FeaturedGames

class ViewExtensionsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCircleFormat() {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        view.circleFormat()
        XCTAssertEqual(view.layer.cornerRadius, 15)
    }
    
    func testFillSubview() {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let subview: GameListView = UIView.fromNib()
        
        view.fillWithSubview(subview: subview)
        XCTAssertTrue(view.subviews.contains(where: { $0.isKind(of: GameListView.self) } ))
        XCTAssertEqual(view.frame.height, subview.frame.height)
        XCTAssertEqual(view.frame.width, subview.frame.width)
    }
    
}
