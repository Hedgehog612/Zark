//
//  Location.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/19/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa


//Location class
//Name and fullname name the room with and without camelCase.
//Description prints when the player is in the room.
//Connections and contents link the room to other rooms and to items.
class Location {
    var id: String
    var fullName: String
    var roomDescription: String
    var connections: [String: String]
    var contents: [String]
    
    init(id idIn: String, fullName fullNameIn: String, roomDescription descriptionIn: String, contents contentsIn: [String] = []) {
        id = idIn
        fullName = fullNameIn
        roomDescription = descriptionIn
        connections = [String: String]()
        contents = contentsIn
    }
    
    
    //Connect
    //Connect builds connections between rooms.
    func connect(direction: String, destination: String) {
        connections[direction] = destination
    }
    
    
    //Describe prints information about the room and about any items in the room.
    func describe() {
        print(roomDescription)
        for id in contents {
            print(game.getItem(id)!.roomDescription)
        }
    }
    
    
    func findItem(name: String) -> Item? {
        guard let item = game.getItemFromName(name) else {
            return nil
        }
        if contents.contains(item.id) {
            return item
        } else {
            return nil
        }
    }
}
