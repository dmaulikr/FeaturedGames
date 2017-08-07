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
            return UIScreen.main.bounds.size.width * 1.2
        case .name:
            return 68
        case .infos:
            return 50
        }
    }
    
    static let allValues = [image, name, infos]
}
