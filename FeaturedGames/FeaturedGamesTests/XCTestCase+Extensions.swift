//
//  XCTestCase+Extensions.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 05/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import ObjectMapper
import XCTest
@testable import FeaturedGames

extension XCTestCase {
    
    var mockedGamesRanking: GamesRanking {
        let path = Bundle.main.path(forResource: "GamesRankingMock", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let jsonResult = try! JSONSerialization.jsonObject(with: data, options: []) as! JSONDictionary
        let result = (jsonResult <*> (GamesRanking.self, nil))
        return result.object!
    }
    
    var mockedGameListViewDTO: GameListViewDTO {
        return GameListViewDTO(imageURL: "https://static-cdn.jtvnw.net/ttv-boxart/Grand%20Theft%20Auto%20V-272x380.jpg",
                               name: "Grand Theft Auto V",
                               rankingPosition: 6)
    }
    
    var mockedAlertDTO: AlertDTO {
        return AlertDTO(title: "testing alert title",
                        message: "testing alert message",
                        positiveActionTitle: "testing alert positive action title",
                        negativeActionTitle: nil)
    }
    
}
