//
//  Links.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 01/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import ObjectMapper

struct Links: Mappable {
    
    var selfLink = ""
    var nextLink = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
    }
    
    mutating func mapping(map: Map) {
        selfLink <- map["self"]
        nextLink <- map["next"]
    }
}

