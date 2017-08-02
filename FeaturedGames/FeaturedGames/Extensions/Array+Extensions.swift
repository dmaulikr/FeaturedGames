//
//  Array+Extensions.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 02/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation

extension Array {
    
    func object(index: Int) -> Element? {
        if index >= 0 && index < self.count {
            return self[index]
        }
        return nil
    }
    
}
