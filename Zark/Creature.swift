//
//  Creature.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/24/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa

class Creature: Entity{
    var nameList: [String]
    var health: Int
    var location: ID
    var behavior: Int
    
    
    //------------------------------------------------------------------------------
    // Initializer
    //------------------------------------------------------------------------------
    init(id idIn: ID, nameList nameListIn: [String], health healthIn: Int, location locationIn: ID, behavior behaviorIn: Int, properties propertiesIn: [PropertyId: Int]? = [:]) {
        nameList = nameListIn
        health = healthIn
        location = locationIn
        behavior = behaviorIn
        
        super.init(id: idIn, properties: (propertiesIn)!)
    }
    
    
    //------------------------------------------------------------------------------
    // takeTurn
    //------------------------------------------------------------------------------
    func takeTurn() {
        return
    }
}
