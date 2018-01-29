//
//  Scores+CoreDataProperties.swift
//  CardGame
//
//  Created by Ganna Melnyk on 1/28/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//
//

import Foundation
import CoreData


extension Scores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Scores> {
        return NSFetchRequest<Scores>(entityName: "Scores")
    }

    @NSManaged public var cards: Int16
    @NSManaged public var name: String?
    @NSManaged public var score: Int16

}
