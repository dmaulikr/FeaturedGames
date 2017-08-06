//
//  ViewControllerExtensionsTest.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 05/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import XCTest
import UIKit
@testable import FeaturedGames

class ViewControllerExtensionsTest: XCTestCase {
    
    let controller = UIViewController()
    
    override func setUp() {
        super.setUp()
        
        UIApplication.shared.keyWindow!.rootViewController = controller
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPresentingConnectionErrorAlert() {
        controller.showConnectionErrorAlert(dto: mockedAlertDTO, completion: nil)
        guard let alert = controller.presentedViewController as? UIAlertController else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(alert.preferredStyle, .alert)
        XCTAssertEqual(alert.title, "testing alert title")
        XCTAssertEqual(alert.message, "testing alert message")
        XCTAssertEqual(alert.actions.count, 1)
        XCTAssertEqual(alert.actions.first?.title, "testing alert positive action title")
        XCTAssertEqual(alert.actions.first?.style, .default)
    }
    
    func testPresentingLoaderView() {
        controller.showLoader()
        XCTAssertTrue(UIApplication.shared.keyWindow!.subviews.contains(where: { $0.isKind(of: LoaderView.self) } ))
    }
    
    func testDismissingLoaderView() {
        testPresentingLoaderView()
        controller.stopLoader()
        XCTAssertFalse(UIApplication.shared.keyWindow!.subviews.contains(where: { $0.isKind(of: LoaderView.self) } ))
    }
}
