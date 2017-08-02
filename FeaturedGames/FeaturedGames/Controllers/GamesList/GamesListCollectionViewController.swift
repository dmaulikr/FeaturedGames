//
//  GamesListCollectionViewController.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 01/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import UIKit

class GamesListCollectionViewController: UICollectionViewController, GamesListDelegate {
    
    // MARK: Properties
    
    private lazy var viewModel: GamesListViewModel = GamesListViewModel(delegate: self)
    
    // MARK: VC Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top #50 Games"
        fetchRemoteService()
    }
    
    private func fetchRemoteService() {
        viewModel.fetchRanking()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfFeaturedGames
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        cell.backgroundColor = .orange
        return cell
    }
    
    // MARK: GamesListDelegate
    
    func fetchedRanking(success: Bool) {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}
