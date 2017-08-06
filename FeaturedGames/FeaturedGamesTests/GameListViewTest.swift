//
//  GameListViewTest.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 05/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import XCTest
@testable import FeaturedGames

class GameListViewTest: XCTestCase {
    
    var gameListView: GameListView?
    
    override func setUp() {
        super.setUp()
        let view: GameListView = UIView.fromNib()
        gameListView = view
        
        UIApplication.shared.keyWindow?.addSubview(gameListView!)
        XCTAssertNotNil(gameListView)
        
        gameListView?.fill(dto: mockedGameListViewDTO)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testComponentsIDs() {
        guard let view = gameListView else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(view.accessibilityIdentifier, "GameListView")
        XCTAssertEqual(view.imageView.accessibilityIdentifier, "GameListView.imageView")
        XCTAssertEqual(view.nameLabel.accessibilityIdentifier, "GameListView.nameLabel")
        XCTAssertEqual(view.rankingPositionTagView.accessibilityIdentifier, "GameListView.rankingPositionView")
        XCTAssertEqual(view.rankingPositionTagLabel.accessibilityIdentifier, "GameListView.rankingPositionLabel")
    }
    
    func testFillValues() {
        guard let view = gameListView else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(view.nameLabel.text, "Grand Theft Auto V")
        XCTAssertNotNil(view.rankingPositionTagView)
        XCTAssertFalse(view.rankingPositionTagView.isHidden)
        XCTAssertEqual(view.rankingPositionTagLabel.text, "#6")
    }
}
