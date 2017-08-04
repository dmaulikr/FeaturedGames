//
//  GameListCollectionViewCell.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 03/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import UIKit
import Kingfisher

class GameListCollectionViewCell: UICollectionViewCell {
    
    let view: GameListView = UIView.fromNib()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fillWithSubview(subview: view)
    }
    
    func fill(dto: GameListViewDTO) {
        view.fill(dto: dto)
    }
    
    func cancelGameImageDownload() {
        view.imageView.kf.cancelDownloadTask()
    }
    
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)!.first as! T
    }
    
    func fillWithSubview(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        
        let views = ["view": subview]
        let vC = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        let hC = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        addConstraints(vC)
        addConstraints(hC)
        updateConstraints()
        
        subview.setNeedsDisplay()
        layoutIfNeeded()
    }
}

extension UICollectionViewCell {
    class func createCell<T: UICollectionViewCell>(collectionView: UICollectionView, indexPath: IndexPath) -> T {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}
