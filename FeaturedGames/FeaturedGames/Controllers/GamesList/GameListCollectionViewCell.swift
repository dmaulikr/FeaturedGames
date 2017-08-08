//
//  GameListCollectionViewCell.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 03/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import UIKit

class GameListCollectionViewCell: UICollectionViewCell {
    
    let view: GameListView = UIView.fromNib()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fillWithSubview(subview: view)
    }
    
    func fill(dto: GameListViewDTO) {
        view.fill(dto: dto)
    }
    
    func cancelImageDownload() {
        view.imageView.pin_cancelImageDownload()
    }
    
}
