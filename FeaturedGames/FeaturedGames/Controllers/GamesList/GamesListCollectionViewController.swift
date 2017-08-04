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
    
    lazy var viewModel: GamesListViewModel = GamesListViewModel(delegate: self)
    private let pullToRefresh = UIRefreshControl()
    
    // MARK: VC Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top #50 Games"
        pullToRefresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = pullToRefresh
        }else {
            collectionView?.addSubview(pullToRefresh)
        }
        fetchRemoteService()
        //teste()
    }
    
    func teste() {
        pullToRefresh.beginRefreshing()
        view.isUserInteractionEnabled = false
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 163, height: 220)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GameListCollectionViewCell = UICollectionViewCell.createCell(collectionView: collectionView, indexPath: indexPath)
        cell.fill(dto: viewModel.getFeaturedGameDTO(at: indexPath.item))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GameListCollectionViewCell {
            cell.cancelGameImageDownload()
        }
    }
    
    // MARK: GamesListDelegate
    
    func fetchedRanking(success: Bool) {
        DispatchQueue.main.async {
            //self.collectionView?.reloadData()
        }
    }
}
