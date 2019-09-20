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
    var name: String
    var fullName: String
    var description: String
    var connections: [String: String]
    var contents: [Item]
    
    init(name nameIn: String, fullName fullNameIn: String, description descriptionIn: String, contents contentsIn: [Item]?) {
        name = nameIn
        fullName = fullNameIn
        description = descriptionIn
        connections = [String: String]()
        contents = [Item]()
    }
    
    
    //Connect
    //Connect builds connections between rooms.
    func connect(direction: String, destination: String) {
        connections[direction] = destination
    }
    
    
    //Describe prints information about the room and about any items in the room.
    func describe() {
        print("calling describe")
        print(description)
        for item in contents {
            print("item description")
            print(item.description)
        }
    }
}
