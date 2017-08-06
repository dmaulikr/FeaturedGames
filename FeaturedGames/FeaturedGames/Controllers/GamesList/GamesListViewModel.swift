//
//  GamesListViewModel.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 01/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation

// MARK: View Model Protocol

protocol GamesListDelegate: class {
    func fetchedRanking(success: Bool, foundedLocalData: Bool)
}

class GamesListViewModel {
    
    // MARK: Properties
    
    private var currentRanking: GamesRanking?
    private weak var delegate: GamesListDelegate?
    private var serviceType: GamesRankingRemoteService.Type
    private var rankingService: GamesRankingRemoteService {
        return serviceType.init()
    }
    
    // MARK: Init
    
    init(delegate: GamesListDelegate, serviceType: GamesRankingRemoteService.Type = GamesRankingRequest.self) {
        self.delegate = delegate
        self.serviceType = serviceType
    }
    
    // MARK: UICollectionViewDataSource Data
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfFeaturedGames: Int {
        return currentRanking?.featuredGames.count ?? 0
    }
    
    // MARK: DTO
    
    func getFeaturedGameDTO(at item: Int) -> GameListViewDTO {
        guard let featuredGame = currentRanking?.featuredGames.object(index: item) else {
            return GameListViewDTO()
        }
        return GameListViewDTO(imageURL: featuredGame.game?.box?.large ?? "",
                               name: featuredGame.game?.name ?? "",
                               rankingPosition: item + 1)
    }
    
    // MARK: Transporter
    
    func gameForTransporter(at index: Int) -> FeaturedGame? {
        return currentRanking?.featuredGames.object(index: index)
    }
    
    // MARK: Remote Service
    
    func fetchRanking() {
        rankingService.fetchRanking { ranking, error in
            guard let ranking = ranking, error == nil else {
                self.delegate?.fetchedRanking(success: false, foundedLocalData: true)
                return
            }
            self.currentRanking = ranking
            self.delegate?.fetchedRanking(success: true, foundedLocalData: true)
        }
    }
    
    // MARK: Local Service
    
    private func saveLocalData() {
        
    }
    
    private func fetchLocalData() {
        
    }
}
