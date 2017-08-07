//
//  GameDetailViewModel.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 06/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import UIKit

class GameDetailViewModel {
    
    private var featuredGame = FeaturedGame()
    private var position: Int?
    
    init() {
    }
    
    // MARK: UITableViewDataSource Data
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return GameDetailCellType.allValues.count
    }
    
    // MARK: DTOs
    
    var gameName: String {
        return featuredGame.game?.name ?? ""
    }
    
    var gameImage: String {
        return featuredGame.game?.box?.large ?? ""
    }
    
    var gameInfos: [GameDetailInfo] {
        var infos = [GameDetailInfo]()
        if let position = position {
            infos.append(("posição".localized, position))
        }
        infos.append(("canais", featuredGame.channels))
        infos.append(("visualizações", featuredGame.viewers))
        return infos
    }
    
    var shareData: String? {
        guard let position = position, let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else {
            return nil
        }
        var message = "\("Você sabia que o jogo".localized) \(gameName) \("está em".localized) #\(position) \("entre os destaques do Twitch?".localized) 👾"
        message += "\n\n\(gameImage)"
        message += "\n\n\("Veja a lista completa no app".localized) \(appName) 🎮"
        return message
    }
    
    // MARK: Transporter
    
    func prepareForNavigation(transporter: Transporter<Any>) {
        if let data = transporter.data as? (featuredGame: FeaturedGame, position: Int) {
            self.featuredGame = data.featuredGame
            self.position = data.position
        }
    }
    
}

typealias GameDetailInfo = (key: String, value: Int)
