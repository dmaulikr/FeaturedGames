//
//  GamesRanking.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 01/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import ObjectMapper

struct GamesRanking: Mappable {
    
    var total = 0
    var links: Links?
    var featuredGames = [FeaturedGame]()
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
    }
    
    mutating func mapping(map: Map) {
        total <- map["_total"]
        links <- map["_links"]
        featuredGames <- map["top"]
    }
}
