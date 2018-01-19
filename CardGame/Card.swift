//
//  Card.swift
//  CardGame
//
//  Created by Ganna Melnyk on 1/17/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import Foundation

class Card {
    var identifier: Int
    
    private static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
