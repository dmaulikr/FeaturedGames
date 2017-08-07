//
//  GameInfosTableViewCell.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 06/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import UIKit

class GameInfosTableViewCell: UITableViewCell {

    let view: GameInfosView = UIView.fromNib()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fillWithSubview(subview: view)
    }
    
    func fill(infos: [GameDetailInfo]) {
        view.fill(infos: infos)
    }
    
}
