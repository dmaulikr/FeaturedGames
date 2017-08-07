//
//  GameInfosView.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 06/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import UIKit

class GameInfosView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var infos = [GameDetailInfo]() {
        didSet {
            DispatchQueue.main.safeAsync {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
    
    func fill(infos: [GameDetailInfo]) {
        self.infos = infos
    }
    
    // MARK: UICollectionViewDataSource
    
    private func registerCell() {
        collectionView.registerCell(identifier: String(describing: GameInfoCollectionViewCell.self))
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 85)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GameInfoCollectionViewCell = UICollectionViewCell.createCell(collectionView: collectionView, indexPath: indexPath)
        if let info = infos.object(index: indexPath.item) {
            cell.fill(info: info)
        }
        cell.accessibilityIdentifier = "\(String(describing: GameInfosView.self)).\(String(describing: GameInfoCollectionViewCell.self)).section_\(indexPath.section).item_\(indexPath.item)"
        return cell
    }
    
}
