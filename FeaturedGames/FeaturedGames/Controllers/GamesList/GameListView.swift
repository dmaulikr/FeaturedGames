//
//  GameListView.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 03/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import PINCache
import PINRemoteImage


struct GameListViewDTO {
    var imageURL = ""
    var name = ""
    var rankingPosition = 0
}

class GameListView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rankingPositionTagView: UIView!
    @IBOutlet weak var rankingPositionTagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setComponentsIDs()
    }
    
    private func setComponentsIDs() {
        accessibilityIdentifier = "GameListView"
        imageView.accessibilityIdentifier = "GameListView.imageView"
        nameLabel.accessibilityIdentifier = "GameListView.nameLabel"
        rankingPositionTagView.accessibilityIdentifier = "GameListView.rankingPositionView"
        rankingPositionTagLabel.accessibilityIdentifier = "GameListView.rankingPositionLabel"
    }
    
    func fill(dto: GameListViewDTO) {
        imageView.downloadImage(with: dto.imageURL)
        nameLabel.fill(with: dto.name, and: .gameName)
        rankingPositionTagView.circleFormat()
        rankingPositionTagView.backgroundColor = Colors.gameRankingPositionTag.color
        rankingPositionTagLabel.fill(with: "\(dto.rankingPosition)", and: .gameRankingPositionTag)
    }
}

extension UIView {
    func circleFormat() {
        layer.cornerRadius = frame.size.height / 2
    }
}

typealias labelStyleAttributes = (font: UIFont, textColor: UIColor)

enum Colors {
    case primary
    case gameName
    case gameRankingPositionTag
    case black
    case gray
    case white
    
    var color: UIColor {
        switch self {
        case .primary:
            return .blue
        case .gameName:
            return .darkGray
        case .gameRankingPositionTag:
            return .red
        case .black:
            return .black
        case .gray:
            return .lightGray
        case .white:
            return .white
        }
    }
}

enum LabelStyle {
    case gameName
    case gameRankingPositionTag
    
    var attributes: labelStyleAttributes {
        switch self {
        case .gameName:
            return (UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold), Colors.gameName.color)
        case .gameRankingPositionTag:
            return (UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold), Colors.white.color)
        }
    }
}

extension UIImageView {
    func downloadImage(with url: String) {
        pin_updateWithProgress = true
        pin_setImage(from: URL(string: url))
    }
}

extension UILabel {
    func fill(with string: String, and style: LabelStyle) {
        text = string
        font = style.attributes.font
        textColor = style.attributes.textColor
    }
}
