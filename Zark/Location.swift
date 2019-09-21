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
class Location {
    var id: LocationID
    var fullName: String
    var roomDescription: String
    var connections: [Direction: LocationID]
    var contents: [ItemID]
    
    
    //------------------------------------------------------------------------------
    // Initializer
    //------------------------------------------------------------------------------
    init(id idIn: LocationID, fullName fullNameIn: String, roomDescription descriptionIn: String, contents contentsIn: [ItemID] = []) {
        id = idIn
        fullName = fullNameIn
        roomDescription = descriptionIn
        connections = [:]
        contents = contentsIn
    }
    
    
    //------------------------------------------------------------------------------
    // connect
    // Adds a connection to another room.
    //------------------------------------------------------------------------------
    func connect(direction: Direction, destination: LocationID) {
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
}


//------------------------------------------------------------------------------
// LocationID enum
//------------------------------------------------------------------------------
enum LocationID {
    case LockerRoom
    case BriefingRoom
    case MapRoom
    case GeodeRoom
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
