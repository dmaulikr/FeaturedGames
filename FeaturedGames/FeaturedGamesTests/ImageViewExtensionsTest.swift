//
//  ImageViewExtensionsTest.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 07/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import XCTest
import UIKit
@testable import FeaturedGames

class ImageViewExtensionsTest: XCTestCase {
    
    let testImageView = UIImageView()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddAndRemoveIndicatorView() {
        XCTAssertFalse(testImageView.subviews.contains(where: { $0.isKind(of: UIActivityIndicatorView.self) }))
        testImageView.addIndicatorView()
        XCTAssertTrue(testImageView.subviews.contains(where: { $0.isKind(of: UIActivityIndicatorView.self) }))
        testImageView.removeIndicatorView()
        XCTAssertFalse(testImageView.subviews.contains(where: { $0.isKind(of: UIActivityIndicatorView.self) }))
    }
    
}
