//
//  GameDetailImageTableViewCell.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 06/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import UIKit

class GameDetailImageTableViewCell: UITableViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gameImageView.accessibilityIdentifier = "\(String(describing: GameDetailImageTableViewCell.self)).gameImageView"
    }

    func fill(imageURL: String) {
        gameImageView.downloadImage(with: imageURL)
    }
}
