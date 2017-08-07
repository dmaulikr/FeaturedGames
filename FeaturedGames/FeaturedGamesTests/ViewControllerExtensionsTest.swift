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
        
        let navigationController = UINavigationController(rootViewController: controller)
        UIApplication.shared.keyWindow!.rootViewController = navigationController
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
    
    func testSpecialNavigation() {
        let title = "testing navigation title"
        controller.addSpecialNavigation(with: title, and: String(describing: ViewControllerExtensionsTest.self))
        guard let customNavigationItem = controller.navigationItem.leftBarButtonItem?.customView as? UILabel else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(controller.title!.isEmpty)
        XCTAssertEqual(customNavigationItem.text, title)
        XCTAssertEqual(customNavigationItem.accessibilityIdentifier, "ViewControllerExtensionsTest.navigation.title")
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
    
    func testAddSpecialNavigation() {
        controller.addSpecialNavigation(with: "testing title", and: "testing_id")
        XCTAssertNotNil(controller.navigationItem.leftBarButtonItem)
        XCTAssertNotNil(controller.navigationItem.leftBarButtonItem?.customView)
        
        guard let item = controller.navigationItem.leftBarButtonItem?.customView as? UILabel else {
            XCTFail()
            return
        }
        
        item.text = "testing title"
        item.accessibilityIdentifier = "testing_id.navigation.title"
    }
}
