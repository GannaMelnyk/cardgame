////
////  GameBrain.swift
////  CardGame
////
////  Created by Ganna Melnyk on 1/15/18.
////  Copyright © 2018 Ganna Melnyk. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class Shuffler {
//
//    var pictures: [UIImage] = [#imageLiteral(resourceName: "027-avocado"), #imageLiteral(resourceName: "014-pitaya"), #imageLiteral(resourceName: "028-radishes"), #imageLiteral(resourceName: "032-cherry"), #imageLiteral(resourceName: "015-pomegranate"), #imageLiteral(resourceName: "005-mangosteen"), #imageLiteral(resourceName: "035-olives"), #imageLiteral(resourceName: "017-peas"), #imageLiteral(resourceName: "038-artichoke"), #imageLiteral(resourceName: "008-pumpkin"), #imageLiteral(resourceName: "046-peach"), #imageLiteral(resourceName: "037-mushroom"), #imageLiteral(resourceName: "012-carambola"), #imageLiteral(resourceName: "045-orange"), #imageLiteral(resourceName: "040-papaya"), #imageLiteral(resourceName: "025-grapes"), #imageLiteral(resourceName: "050-garlic"), #imageLiteral(resourceName: "024-strawberry"), #imageLiteral(resourceName: "049-watermelon"), #imageLiteral(resourceName: "034-blueberries"), #imageLiteral(resourceName: "047-chili"), #imageLiteral(resourceName: "003-corn"), #imageLiteral(resourceName: "016-melon"), #imageLiteral(resourceName: "004-pear"), #imageLiteral(resourceName: "022-peanut"), #imageLiteral(resourceName: "042-cabbage"), #imageLiteral(resourceName: "001-tomato"), #imageLiteral(resourceName: "002-lettuce"), #imageLiteral(resourceName: "009-mango"), #imageLiteral(resourceName: "011-coconut"), #imageLiteral(resourceName: "020-cauliflower"), #imageLiteral(resourceName: "044-courgette"), #imageLiteral(resourceName: "039-carrot"), #imageLiteral(resourceName: "043-lemon")]
//
//    var cards = [Card]()
//
//    init(numberOfPairsOfCards: Int) {
//        var unShuffledCards: [Card] = []
//        for _ in 1...numberOfPairsOfCards {
//            let card = Card()
//            unShuffledCards += [card, card]
//        }
//        while !unShuffledCards.isEmpty {
//            let randomIndex = Int(arc4random_uniform(UInt32(unShuffledCards.count)))
//            let card = unShuffledCards.remove(at: randomIndex)
//            cards.append(card)
//        }
//    }
//
//    private var shuffledPics = [Int: UIImage]()
//
//    func pictureForCell(for card: Card) -> UIImage {
//        if shuffledPics[card.identifier] == nil, pictures.count > 0 {
//            let randomIndex = Int(arc4random_uniform(UInt32(pictures.count - 1)))
//            shuffledPics[card.identifier] = pictures.remove(at: randomIndex)
//        }
//        return shuffledPics[card.identifier] ?? UIImage(named: "background.png")!
//    }
//
//}

