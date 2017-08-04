//
//  GamesListCollectionViewController.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 01/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import UIKit
import Foundation

class GamesListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, GamesListDelegate {
    
    // MARK: Properties
    
    lazy var viewModel: GamesListViewModel = GamesListViewModel(delegate: self)
    private let refreshControl = UIRefreshControl()
    
    // MARK: VC Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top #50 Games"
        setupRefreshControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchRemoteService()
    }
    
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "",
                                                            attributes: [NSForegroundColorAttributeName: Colors.gameName.color])
        refreshControl.tintColor = Colors.gameName.color
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshControl
        }else {
            collectionView?.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(fetchRemoteService), for: .valueChanged)
    }
    
    func fetchRemoteService() {
        DispatchQueue.main.safeAsync {
            self.view.isUserInteractionEnabled = false
            self.showLoader()
            self.refreshControl.beginRefreshing()
        }
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
        let cell: GameListCollectionViewCell = UICollectionViewCell.createCell(collectionView: collectionView, indexPath: indexPath)
        cell.fill(dto: viewModel.getFeaturedGameDTO(at: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth * 1.56)
    }
    
    // MARK: Cell size calculus
    
    var cellWidth: CGFloat {
        let screenWidth = Int(view.frame.size.width)
        let minimumCellWidth = 200
        let minimumNumberOfCells = 2
        
        var numberOfCells = minimumNumberOfCells
        if screenWidth > minimumCellWidth * minimumNumberOfCells {
            let quotient = CGFloat(screenWidth / minimumCellWidth)
            let remainder = quotient.truncatingRemainder(dividingBy: 1)
            numberOfCells = Int(quotient - remainder)
        }
        
        let cellsAndBorderSpaces = CGFloat((numberOfCells - 1) * 5) + CGFloat(10)
        return (CGFloat(screenWidth) - cellsAndBorderSpaces) / CGFloat(numberOfCells)
    }
    
    // MARK: GamesListDelegate
    
    func fetchedRanking(success: Bool, foundedLocalData: Bool) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.view.isUserInteractionEnabled = true
            self.collectionView?.reloadData()
            self.stopLoader()
            if !success {
                self.showConnectionErrorAlert(dto: self.connectionErrorAlertDTO, completion: { action in
                    if action.title == self.connectionErrorAlertDTO.positiveActionTitle {
                        if !foundedLocalData {
                            self.showLoader()
                        }
                        self.fetchRemoteService()
                    }
                })
            }
        }
    }
    
    var connectionErrorAlertDTO: AlertDTO {
        return AlertDTO(title: "Aviso", message: "Ocorreu uma falha na conexão ao carregar os jogos", positiveActionTitle: "Tentar novamente", negativeActionTitle: "Cancelar")
    }
}
