//
//  GameDetailNameTableViewCell.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 06/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import UIKit

class GameDetailNameTableViewCell: UITableViewCell {

    @IBOutlet weak var gameNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gameNameLabel.accessibilityIdentifier = "\(String(describing: GameDetailNameTableViewCell.self)).gameNameLabel"
    }
    
    func fill(name: String) {
        gameNameLabel.fill(with: name, and: .gameNameDetail)
    }
}
