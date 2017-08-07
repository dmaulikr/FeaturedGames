//
//  GameDetailViewModelTest.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 07/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import XCTest
@testable import FeaturedGames

class GameDetailViewModelTest: XCTestCase {
    
    let viewModel: GameDetailViewModel = GameDetailViewModel()
    
    override func setUp() {
        super.setUp()
        
        viewModel.prepareForNavigation(transporter: mockedGameDetailTransporter!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testViewModelData() {
        XCTAssertEqual(viewModel.numberOfSections, 1)
        XCTAssertEqual(viewModel.numberOfRows, 3)
        XCTAssertEqual(viewModel.gameName, "PLAYERUNKNOWN'S BATTLEGROUNDS")
        XCTAssertEqual(viewModel.gameImage, "https://static-cdn.jtvnw.net/ttv-boxart/PLAYERUNKNOWN%27S%20BATTLEGROUNDS-272x380.jpg")
        XCTAssertEqual(viewModel.gameInfos.count, 3)
        XCTAssertEqual(viewModel.gameInfos.last?.key, "visualizações".localized)
        XCTAssertEqual(viewModel.gameInfos.last?.value, 102358)
        XCTAssertEqual(viewModel.shareData, "\("Você sabia que o jogo".localized) PLAYERUNKNOWN\'S BATTLEGROUNDS \("está em".localized) #1 \("entre os destaques do Twitch?".localized) 👾\n\nhttps://static-cdn.jtvnw.net/ttv-boxart/PLAYERUNKNOWN%27S%20BATTLEGROUNDS-272x380.jpg\n\n\("Veja a lista completa no app".localized) #50 Games 🎮")
    }
    
}
