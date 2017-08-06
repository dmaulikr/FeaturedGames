//
//  ViewControllerBuilder.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 06/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import UIKit

class Transporter<T> {
    var data: T!
    
    init(data: T) {
        self.data = data
    }
    
    init() {
        
    }
}

protocol ViewControllerBuilder: class {
    func build() -> UIViewController
}

class GameDetailControllerBuilder: ViewControllerBuilder {
    private var featureGame: FeaturedGame?
    private var position: Int?
    private var transporter: Transporter<Any>? {
        if let game = featureGame, let position = position {
            return Transporter(data: (game, position))
        }
        return nil
    }
    
    init(featureGame: FeaturedGame, position: Int) {
        self.featureGame = featureGame
        self.position = position
    }
    
    func build() -> UIViewController {
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: GameDetailTableViewController.self)) as? GameDetailTableViewController, let transporter = transporter else {
            return UIViewController()
        }
        controller.prepareForNavigation(transporter: transporter)
        return controller
    }
}
