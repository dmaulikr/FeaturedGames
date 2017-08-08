//
//  GamesListViewModelTest.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 05/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import XCTest
@testable import FeaturedGames

class GamesListViewModelTest: XCTestCase {
    
    let viewModel = GamesListViewModel(delegate: GamesListCollectionViewController(), serviceType: GamesRankingMockRequest.self)
    
    override func setUp() {
        super.setUp()
        viewModel.fetchRemoteRanking()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDataSourceInterfaceData() {
        XCTAssertEqual(viewModel.numberOfSections, 1)
        XCTAssertEqual(viewModel.numberOfFeaturedGames, 50)
        XCTAssertTrue(viewModel.getFeaturedGameDTO(at: 5) == mockedGameListViewDTO)
    }
}
