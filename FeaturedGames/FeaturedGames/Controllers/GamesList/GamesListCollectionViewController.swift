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
    private var screenID: String {
        return String(describing: GamesListCollectionViewController.self)
    }
    
    // MARK: VC Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSpecialNavigation(with: "#50 Games".localized, and: screenID)
        setupRefreshControl()
        fetchRemoteService()
        fetchLocalService()
    }
    
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: Colors.primary.color])
        refreshControl.tintColor = Colors.primary.color
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshControl
        }else {
            collectionView?.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(fetchRemoteService), for: .valueChanged)
        refreshControl.accessibilityIdentifier = "\(screenID).refreshControl"
    }
    
    func fetchRemoteService() {
        DispatchQueue.main.safeAsync {
            self.view.isUserInteractionEnabled = false
            self.showLoader()
            self.refreshControl.beginRefreshing()
        }
        viewModel.fetchRemoteRanking()
    }
    
    func fetchLocalService() {
        viewModel.fetchLocalRanking()
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
        cell.accessibilityIdentifier = "\(screenID).\(String(describing: GameListCollectionViewCell.self)).section_\(indexPath.section).item_\(indexPath.item)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth * 1.56)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GameListCollectionViewCell {
            cell.cancelImageDownload()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let game = viewModel.gameForTransporter(at: indexPath.item) {
            navigationController?.pushViewController(GameDetailControllerBuilder(featureGame: game, position: indexPath.item + 1).build(), animated: true)
        }
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
    
    func fetchedRemoteRanking(success: Bool, foundedLocalData: Bool) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.view.isUserInteractionEnabled = true
            self.collectionView?.reloadData()
            self.stopLoader()
            if !success {
                let alertDTO = self.connectionErrorAlertDTO(foundedLocalData: foundedLocalData)
                self.showConnectionErrorAlert(dto: alertDTO, completion: { action in
                    if action.title == alertDTO.positiveActionTitle {
                        self.fetchRemoteService()
                    }
                })
            }
        }
    }
    
    func fetchedLocalRanking() {
        DispatchQueue.main.safeAsync {
            self.collectionView?.reloadData()
        }
    }
    
    func connectionErrorAlertDTO(foundedLocalData: Bool) -> AlertDTO {
        var message = "Ocorreu uma falha na conexão ao carregar os jogos.".localized
        message += foundedLocalData ? "\n\("Os dados exibidos podem estar desatualizados.".localized)" : ""
        message += "\n\("Deseja tentar novamente?".localized)"
        return AlertDTO(title: "Aviso".localized,
                        message: message,
                        positiveActionTitle: "Tentar novamente".localized,
                        negativeActionTitle: "Cancelar".localized)
    }
}
