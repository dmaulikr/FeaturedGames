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
    
    var attributes: labelStyleAttributes {
        switch self {
        case .navigation:
            return (UIFont.systemFont(ofSize: 20, weight: UIFontWeightSemibold), Colors.white.color)
        case .gameName:
            return (UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold), Colors.gameName.color)
        case .gameRankingPositionTag:
            return (UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold), Colors.white.color)
        }
    }
}

enum Colors {
    case primary
    case gameName
    case gameRankingPositionTag
    case white
    case black
    
    var color: UIColor {
        switch self {
        case .primary:
            return UIColor(red: 31/255, green: 145/255, blue: 203/255, alpha: 1.0)
        case .gameName:
            return UIColor(red: 20/255, green: 101/255, blue: 150/255, alpha: 1.0)
        case .gameRankingPositionTag:
            return UIColor(red: 48/255, green: 173/255, blue: 234/255, alpha: 1.0)
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
