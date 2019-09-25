//
//  Entity.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/22/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation

class Entity {
    var id: ID
    var properties: [PropertyId: Int]
    
    
    //initializer
    init(id idIn: ID, properties propertiesIn: [PropertyId: Int]) {
        id = idIn
        properties = propertiesIn
    }
    
    
    
}


//------------------------------------------------------------------------------
// ID enum
//------------------------------------------------------------------------------
enum ID {
    //These are the locations
    case LockerRoom
    case BriefingRoom
    case MapRoom
    case GeodeRoom
    case ViewingRoom
    case DarkRoom
    case ArchiveRoom
    case MoonRoom
    
    //These are the items
    case Lamp
    case Geode
    case Key
    case Lantern
    case Button
    case Door
    case Crystal
    
    //These are the creatures
    case Orc
}
