//
//  GamesListViewModel.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 01/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import CoreData

// MARK: View Model Protocol

protocol GamesListDelegate: class {
    func fetchedRemoteRanking(success: Bool, foundedLocalData: Bool)
    func fetchedLocalRanking()
}

class GamesListViewModel {
    
    // MARK: Properties
    
    private var currentRanking = GamesRanking()
    private var currentFeaturedGames: [FeaturedGame] {
        return currentRanking.featuredGames
    }
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
        return currentFeaturedGames.count
    }
    
    // MARK: DTO
    
    func getFeaturedGameDTO(at item: Int) -> GameListViewDTO {
        guard let featuredGame = currentFeaturedGames.object(index: item) else {
            return GameListViewDTO()
        }
        return GameListViewDTO(imageURL: featuredGame.game?.box?.large ?? "",
                               name: featuredGame.game?.name ?? "",
                               rankingPosition: item + 1)
    }
    
    // MARK: Transporter
    
    func gameForTransporter(at index: Int) -> FeaturedGame? {
        return currentFeaturedGames.object(index: index)
    }
    
    // MARK: Remote Service
    
    private func saveLocalData() {
        let managedContext = dataManager.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "FeaturedGameObject", in: managedContext) else {
            return
        }
        // manage object setValue
        do {
            try managedContext.save()
        } catch _ as NSError {
            print("")
        }
    }
    
    func fetchRemoteRanking() {
        rankingService.fetchRanking { ranking, error in
            guard let ranking = ranking, !ranking.featuredGames.isEmpty , error == nil else {
                self.delegate?.fetchedRemoteRanking(success: false,
                                                    foundedLocalData: !self.currentFeaturedGames.isEmpty)
                return
            }
            self.currentRanking = ranking
            self.saveLocalRanking(ranking: ranking.featuredGames)
            self.delegate?.fetchedRemoteRanking(success: true, foundedLocalData: true)
        }
    }
    
    // MARK: Local Service
    
    func fetchLocalRanking() {
        FeaturedGamePersister().fetch { ranking in
            if !ranking.isEmpty {
                self.currentRanking.featuredGames = ranking
                self.delegate?.fetchedLocalRanking()
            }
        }
    }
    
    private func saveLocalRanking(ranking: [FeaturedGame]) {
        FeaturedGamePersister().delete { _ in }
        FeaturedGamePersister().save(featuredGames: ranking) { _ in }
    }
    
}
