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
    func fetchedRanking(success: Bool, foundedLocalData: Bool)
}

@available(iOS 10.0, *)
class GamesListViewModel {
    
    // MARK: Properties
    
    private let dataManager = LocalDataManager()
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
            self.fetchLocalData()
            self.currentRanking = ranking
            self.delegate?.fetchedRanking(success: true, foundedLocalData: true)
        }
    }
    
    // MARK: Local Service
    
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
    
    func fetchLocalData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FeaturedGameObject")
        let context = dataManager.persistentContainer.viewContext
        do {
            let results = try context.fetch(fetchRequest)
            if let results = results as? [FeaturedGameObject] {
                print(results)
            }
        } catch {
            print("")
        }
    }
    
    func deleteAll() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "FeaturedGameObject")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        let context = dataManager.persistentContainer.viewContext
        do {
            try context.execute(request)
        } catch _ as NSError {
            print("")
        }
    }
}
