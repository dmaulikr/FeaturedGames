//
//  GameDetailCellType.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 06/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import UIKit

enum GameDetailCellType: Int {
    case image
    case name
    case infos
    
    init(row: Int) {
        self = GameDetailCellType(rawValue: row) ?? .infos
    }
    
    var height: CGFloat {
        switch self {
        case .image:
            return 50
        case .name:
            return 50
        case .infos:
            return 50
        }
    }
    
    static let allValues = [image, name, infos]
}
