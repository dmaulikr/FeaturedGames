//
//  GameListView.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 03/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import UIKit

struct GameListViewDTO: Equatable {
    var imageURL = ""
    var name = ""
    var rankingPosition = 0
    
    static func == (lhs: GameListViewDTO, rhs: GameListViewDTO) -> Bool {
        return lhs.imageURL == rhs.imageURL && lhs.name == rhs.name && lhs.rankingPosition == rhs.rankingPosition
    }
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
