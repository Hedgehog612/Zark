//
//  Creature.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/24/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa

class Creature: Entity {
    var nameList: [String]
    var health: Int
    var location: ID
    var behavior: BehaviorID
    var description: String
    var patrol: [ID]
    
    
    //------------------------------------------------------------------------------
    // Initializer
    //------------------------------------------------------------------------------
    init(id idIn: ID, nameList nameListIn: [String], health healthIn: Int, location locationIn: ID, behavior behaviorIn: BehaviorID, description descriptionIn: String, properties propertiesIn: [PropertyId: Int]? = [:], patrol patrolIn: [ID] = []) {
        nameList = nameListIn
        health = healthIn
        location = locationIn
        behavior = behaviorIn
        description = descriptionIn
        patrol = patrolIn
        
        super.init(id: idIn, properties: (propertiesIn)!)
    }
    
    
    //------------------------------------------------------------------------------
    // takeTurn
    //------------------------------------------------------------------------------
    func takeTurn() {
        switch behavior {
        case .Hunter:
            let currentIndex = patrol.firstIndex(of: location)!
            let nextIndex = currentIndex == patrol.count - 1 ? 0 : currentIndex + 1
            location = patrol[nextIndex]
        }
    }

    
    //------------------------------------------------------------------------------
    // describe
    //------------------------------------------------------------------------------
    func describe() {
       print(description)
    }
    
    
    
    
    
    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    // Encoding and decoding
    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    
    
    // Our coding keys
    enum CodingKeys: String, CodingKey {
        case id
        case properties
        case nameList
        case health
        case location
        case behavior
        case description
        case patrol
    }
    

    //------------------------------------------------------------------------------
    // encode
    //------------------------------------------------------------------------------
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(properties, forKey: .properties)
        try container.encode(nameList, forKey: .nameList)
        try container.encode(health, forKey: .health)
        try container.encode(location, forKey: .location)
        try container.encode(behavior, forKey: .behavior)
        try container.encode(description, forKey: .description)
        try container.encode(patrol, forKey: .patrol)
    }
    

    //------------------------------------------------------------------------------
    // decode
    //------------------------------------------------------------------------------
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let idTemp = try values.decode(ID.self, forKey: .id)
        let propertiesTemp = try values.decode([PropertyId: Int].self, forKey: .properties)
        
        nameList = try values.decode([String].self, forKey: .nameList)
        health = try values.decode(Int.self, forKey: .health)
        location = try values.decode(ID.self, forKey: .health)
        behavior = try values.decode(BehaviorID.self, forKey: .behavior)
        description = try values.decode(String.self, forKey: .description)
        patrol = try values.decode([ID].self, forKey: .patrol)

        super.init(id: idTemp, properties: propertiesTemp)
    }

}

enum BehaviorID: String, Codable {
    case Hunter
}
