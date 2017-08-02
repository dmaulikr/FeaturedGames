//
//  GamesRankingService.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 01/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: Remote Service Protocol

protocol GamesRankingRemoteService {
    init()
    func fetchRanking(completion: @escaping (_ user: GamesRanking?, _ error: Error?) -> Void)
}

// MARK: Request

class GamesRankingRequest: GamesRankingRemoteService {
    
    required init() {
    }
    
    func fetchRanking(completion: @escaping (GamesRanking?, Error?) -> Void) {
        completion(nil, nil)
    }
}

// MARK: Mock

class GamesRankingMockRequest: GamesRankingRemoteService {
    
    required init() {
    }
    
    func fetchRanking(completion: @escaping (GamesRanking?, Error?) -> Void) {
        let path = Bundle.main.path(forResource: "GamesRankingMock", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let jsonResult = try! JSONSerialization.jsonObject(with: data, options: []) as! JSONDictionary
        let result = (jsonResult <*> (GamesRanking.self, nil))
        completion(result.object, nil)
    }
}
