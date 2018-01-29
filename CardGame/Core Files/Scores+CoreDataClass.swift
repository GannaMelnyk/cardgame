//
//  Scores+CoreDataClass.swift
//  CardGame
//
//  Created by Ganna Melnyk on 1/28/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//
//

import Foundation
import CoreData


public class Scores: NSManagedObject {
    
    convenience init() {
        self.init(entity: FetchedResultManager.instance.entityForName(entityName: "Scores"), insertInto: FetchedResultManager.instance.managedObjectContext)
    }
}
