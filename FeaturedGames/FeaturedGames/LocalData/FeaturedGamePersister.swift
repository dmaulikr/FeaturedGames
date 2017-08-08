//
//  FeaturedGamePersister.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 08/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import CoreData

protocol FeaturedGamePersisterProtocol: class {
    init()
    func save(featuredGames: [FeaturedGame], completion: @escaping (_ success: Bool) -> Void)
    func fetch(completion: @escaping (_ featuredGames: [FeaturedGame]) -> Void)
    func delete(completion: @escaping (_ success: Bool) -> Void)
}

class FeaturedGamePersister: FeaturedGamePersisterProtocol {
    
    private var entityName: String {
        return String(describing: FeaturedGameObject.self)
    }
    
    required init() {
    }
    
    // MARK: FeaturedGamePersisterProtocol
    
    func save(featuredGames: [FeaturedGame], completion: @escaping (_ success: Bool) -> Void) {
        for (index, featuredGame) in featuredGames.enumerated() {
            if #available(iOS 10.0, *) {
                let object = FeaturedGameObject(context: LocalDataManager.managedObjectContext)
                object.name = featuredGame.game?.name ?? ""
                object.imageURL = featuredGame.game?.box?.large ?? ""
                object.position = Int32(index)
                object.viewers = Int32(featuredGame.viewers)
                object.channels = Int32(featuredGame.channels)
            } else {
                let entityDescriptor = NSEntityDescription.entity(forEntityName: entityName, in: LocalDataManager.managedObjectContext)
                let object = FeaturedGameObject(entity: entityDescriptor ?? NSEntityDescription(),
                                                insertInto: LocalDataManager.managedObjectContext)
                object.name = featuredGame.game?.name ?? ""
                object.imageURL = featuredGame.game?.box?.large ?? ""
                object.position = Int32(index)
                object.viewers = Int32(featuredGame.viewers)
                object.channels = Int32(featuredGame.channels)
            }
            LocalDataManager.saveContext()
        }
        completion(true)
    }
    
    func fetch(completion: @escaping (_ featuredGames: [FeaturedGame]) -> Void) {
        let request: NSFetchRequest<NSFetchRequestResult>
        if #available(iOS 10.0, *) {
            request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        } else {
            request = NSFetchRequest(entityName: entityName)
        }
        do {
            if let results = try LocalDataManager.managedObjectContext.fetch(request) as? [FeaturedGameObject] {
                var entityArray = [FeaturedGame]()
                results.sorted(by: { $0.position < $1.position }).forEach({ object in
                    if let convertedEntity = convertObjectToEntity(object: object) {
                        entityArray.append(convertedEntity)
                    }
                })
                completion(entityArray)
            }
        } catch _ {
            completion([])
        }
    }
    
    func delete(completion: @escaping (_ success: Bool) -> Void) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        let context = LocalDataManager.managedObjectContext
        do {
            try context.execute(request)
            completion(true)
        } catch _ {
            completion(false)
        }
    }
    
    // MARK: Convert funcs
    
    private func convertObjectToEntity(object: FeaturedGameObject) -> FeaturedGame? {
        guard let name = object.name, let image = object.imageURL else {
            return nil
        }
        return FeaturedGame(name: name, imageURL: image, viewers: Int(object.viewers), channels: Int(object.channels))
    }
    
}
