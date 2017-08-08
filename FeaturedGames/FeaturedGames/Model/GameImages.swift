//
//  GameImages.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 01/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import ObjectMapper

struct GameImages: Mappable {
    
    var large = ""
    var medium = ""
    var small = ""
    var template = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
    }
    
    init(imageURL: String) {
        large = imageURL
    }
    
    mutating func mapping(map: Map) {
        large <- map["large"]
        medium <- map["medium"]
        small <- map["small"]
        template <- map["template"]
    }
}
