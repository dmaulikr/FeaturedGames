//
//  FeaturedGame.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 01/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import ObjectMapper

struct FeaturedGame: Mappable {
    
    var game: Game?
    var viewers = 0
    var channels = 0
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
    }
    
    init(name: String, imageURL: String, viewers: Int, channels: Int) {
        game = Game(name: name, imageURL: imageURL)
        self.viewers = viewers
        self.channels = channels
    }
    
    mutating func mapping(map: Map) {
        game <- map["game"]
        viewers <- map["viewers"]
        channels <- map["channels"]
    }
}
