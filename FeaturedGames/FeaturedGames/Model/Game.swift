//
//  Game.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 01/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import ObjectMapper

struct Game: Mappable {
    
    var name = ""
    var popularity = 0
    var id = 0
    var giantBombId = 0
    var box: GameImages?
    var logo: GameImages?
    var links: Links?
    var localizedName = ""
    var locale = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
    }
    
    init(name: String, imageURL: String) {
        self.name = name
        box = GameImages(imageURL: imageURL)
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        popularity <- map["popularity"]
        id <- map["_id"]
        giantBombId <- map["giantbomb_id"]
        box <- map["box"]
        logo <- map["logo"]
        links <- map["_links"]
        localizedName <- map["localized_name"]
        locale <- map["locale"]
    }
}
