//
//  GameInfoCollectionViewCell.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 06/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import UIKit

typealias GameDetailInfo = (key: String, value: Int)

class GameInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setComponentsIDs()
    }
    
    private func setComponentsIDs() {
        accessibilityIdentifier = "\(String(describing: GameInfoCollectionViewCell.self))"
        keyLabel.accessibilityIdentifier = "\(String(describing: GameInfoCollectionViewCell.self)).keyLabel"
        valueLabel.accessibilityIdentifier = "\(String(describing: GameInfoCollectionViewCell.self)).valueLabel"
    }
    
    func fill(info: GameDetailInfo) {
        keyLabel.fill(with: info.key, and: .gameInfoKey)
        valueLabel.fill(with: "\(info.value)", and: .gameInfoValue)
    }
    
}
