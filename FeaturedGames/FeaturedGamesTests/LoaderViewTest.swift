//
//  LoaderViewTest.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 05/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import XCTest
@testable import FeaturedGames

class LoaderViewTest: XCTestCase {
    
    var loaderView: LoaderView?
    
    override func setUp() {
        super.setUp()
        
        let view: LoaderView = UIView.fromNib()
        loaderView = view
        
        UIApplication.shared.keyWindow?.addSubview(loaderView!)
        XCTAssertNotNil(loaderView)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testComponentsIDs() {
        guard let view = loaderView else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(view.accessibilityIdentifier, "LoaderView")
        XCTAssertEqual(view.indicatorView.accessibilityIdentifier, "LoaderView.indicatorView")
        XCTAssertEqual(view.loadingMessageLabel.accessibilityIdentifier, "LoaderView.loadingMessageLabel")
    }
    
    func testAppearence() {
        guard let view = loaderView else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(view.backgroundView.backgroundColor, UIColor.black.withAlphaComponent(0.9))
        XCTAssertEqual(view.alertView.layer.cornerRadius, 20)
        XCTAssertEqual(view.loadingMessageLabel.textColor, UIColor(red: 219/255, green: 81/255, blue: 73/255, alpha: 1.0))
        XCTAssertEqual(view.indicatorView.color, UIColor(red: 219/255, green: 81/255, blue: 73/255, alpha: 1.0))
    }
    
    func testAnimation() {
        guard let view = loaderView else {
            XCTFail()
            return
        }
        let loadingMessage = "testing loader message"
        loaderView!.startAnimation(with: loadingMessage)
        
        XCTAssertEqual(view.loadingMessageLabel.text, loadingMessage)
        XCTAssertTrue(view.indicatorView.isAnimating)
    }
    
}
