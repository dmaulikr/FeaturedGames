//
//  UILabel+Extensions.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 04/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import UIKit

typealias labelStyleAttributes = (font: UIFont, textColor: UIColor)

enum LabelStyle {
    case navigation
    case gameName
    case gameRankingPositionTag
    case gameNameDetail
    
    var attributes: labelStyleAttributes {
        switch self {
        case .navigation:
            return (UIFont.systemFont(ofSize: 24, weight: UIFontWeightSemibold), Colors.primary.color)
        case .gameName:
            return (UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold), Colors.primary.color)
        case .gameRankingPositionTag:
            return (UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold), Colors.white.color)
        case .gameNameDetail:
            return (UIFont.systemFont(ofSize: 20, weight: UIFontWeightSemibold), Colors.primary.color)
        }
    }
}

enum Colors {
    case primary
    case positionTag
    case white
    case black
    
    var color: UIColor {
        switch self {
        case .primary:
            return UIColor(red: 219/255, green: 81/255, blue: 73/255, alpha: 1.0)
        case .positionTag:
            return UIColor(red: 254/255, green: 210/255, blue: 0/255, alpha: 1.0)
        case .white:
            return .white
        case .black:
            return .black
        }
    }
}

extension UILabel {
    
    func fill(with string: String, and style: LabelStyle) {
        text = string
        font = style.attributes.font
        textColor = style.attributes.textColor
    }
    
}
