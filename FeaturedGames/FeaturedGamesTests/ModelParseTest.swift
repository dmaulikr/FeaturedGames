//
//  ModelParseTest.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 05/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import XCTest
@testable import FeaturedGames

class ModelParseTest: XCTestCase {
    
    var gamesRanking: GamesRanking?
    var links: Links?
    var featureGame: FeaturedGame?
    var game: Game?
    var gameImages: GameImages?
    
    override func setUp() {
        super.setUp()
        
        gamesRanking = mockedGamesRanking
        links = mockedGamesRanking.links
        featureGame = mockedGamesRanking.featuredGames.first
        game = mockedGamesRanking.featuredGames.first?.game
        gameImages = mockedGamesRanking.featuredGames.first?.game?.logo
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGamesRanking() {
        guard let model = gamesRanking else {
            XCTFail()
            return
        }
        XCTAssertEqual(model.total, 1564)
        XCTAssertNotNil(model.links)
        XCTAssertNotNil(model.featuredGames)
        XCTAssertEqual(model.featuredGames.count, 50)
    }
    
    func testLinks() {
        guard let model = links else {
            XCTFail()
            return
        }
        XCTAssertEqual(model.selfLink, "https://api.twitch.tv/kraken/games/top?limit=50")
        XCTAssertEqual(model.nextLink, "https://api.twitch.tv/kraken/games/top?limit=50&offset=50")
    }
    
    func testFeatureGames() {
        guard let model = featureGame else {
            XCTFail()
            return
        }
        XCTAssertEqual(model.viewers, 102358)
        XCTAssertEqual(model.channels, 3089)
        XCTAssertNotNil(model.game)
    }
    
    func testGame() {
        guard let model = game else {
            XCTFail()
            return
        }
        XCTAssertEqual(model.name, "PLAYERUNKNOWN'S BATTLEGROUNDS")
        XCTAssertEqual(model.popularity, 102955)
        XCTAssertEqual(model.id, 493057)
        XCTAssertEqual(model.giantBombId, 54979)
        XCTAssertEqual(model.localizedName, "PLAYERUNKNOWN'S BATTLEGROUNDS")
        XCTAssertEqual(model.locale, "pt-br")
        XCTAssertNotNil(model.box)
        XCTAssertNotNil(model.logo)
        XCTAssertNotNil(model.links)
    }
    
    func testGameImages() {
        guard let model = gameImages else {
            XCTFail()
            return
        }
        XCTAssertEqual(model.large, "https://static-cdn.jtvnw.net/ttv-logoart/PLAYERUNKNOWN%27S%20BATTLEGROUNDS-240x144.jpg")
        XCTAssertEqual(model.medium, "https://static-cdn.jtvnw.net/ttv-logoart/PLAYERUNKNOWN%27S%20BATTLEGROUNDS-120x72.jpg")
        XCTAssertEqual(model.small, "https://static-cdn.jtvnw.net/ttv-logoart/PLAYERUNKNOWN%27S%20BATTLEGROUNDS-60x36.jpg")
        XCTAssertEqual(model.template, "https://static-cdn.jtvnw.net/ttv-logoart/PLAYERUNKNOWN%27S%20BATTLEGROUNDS-{width}x{height}.jpg")
    }
}
