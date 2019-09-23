//
//  Location.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/19/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa


//------------------------------------------------------------------------------
// Location
// Name and fullname name the room with and without camelCase.
// Description prints when the player is in the room.
// Connections and contents link the room to other rooms and to items.
//------------------------------------------------------------------------------
class Location: Entity {
    var fullName: String
    var roomDescription: String
    var connections: [Direction: ID]
    var contents: [ID]
    
    
    //------------------------------------------------------------------------------
    // Initializer
    //------------------------------------------------------------------------------
    init(id idIn: ID, fullName fullNameIn: String, roomDescription descriptionIn: String, contents contentsIn: [ID] = [], properties propertiesIn: [PropertyId: Int]) {
        fullName = fullNameIn
        roomDescription = descriptionIn
        connections = [:]
        contents = contentsIn
        
        super.init(id: idIn, properties: propertiesIn)
    }
    
    
    //------------------------------------------------------------------------------
    // connect
    // Adds a connection to another room.
    //------------------------------------------------------------------------------
    func connect(direction: Direction, destination: ID) {
        connections[direction] = destination
    }
    

    //------------------------------------------------------------------------------
    // describe
    // Prints information about the room and about any items in the room.
    //------------------------------------------------------------------------------
    func describe() {
        print(roomDescription)
        for id in contents {
            game.itemFromId(id).describe()
        }
    }
    
    
    //------------------------------------------------------------------------------
    // itemFromName
    // Finds an item with a specified human-friendly name and checks if it's present
    // in this location.
    //------------------------------------------------------------------------------
    func itemFromName(name: String) -> Item? {
        guard let item = game.itemFromName(name) else {
            return nil
        }
        if contents.contains(item.id) {
            return item
        } else {
            return nil
        }
    }
    
    //------------------------------------------------------------------------------
    // containsItem
    // Returns whether or not a specified item is in this location.
    //------------------------------------------------------------------------------
    func containsItem(_ itemID: ID) -> Bool {
        return contents.contains(itemID)
    }
}


//------------------------------------------------------------------------------
// Direction enum
//------------------------------------------------------------------------------
enum Direction {
    case North
    case South
    case East
    case West
    case Northeast
    case Northwest
    case Southeast
    case Southwest
}
