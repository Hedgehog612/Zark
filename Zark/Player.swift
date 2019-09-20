//
//  Player.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/19/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa

class Player {
    var inventory: [Item]
    var location: String
    
    init(location locationIn: String) {
        inventory = []
        location = locationIn
    }
    
    
    //Move
    //This function moves the player between connected locations
    func move(direction: String) {
        if let newLocation = game.getLocation(location)!.connections[direction] {
            location = newLocation
        } else {
            print("Cannot move there")
        }
    }
    
    
    //Get
    //This function picks up an item and puts it in the player's inventory
    func get(item: String) {
        if let itemList = game.getLocation(location)?.contents {
            var objectCount = 0
            for object in itemList {
                if object.names.contains(item) {
                    inventory.append(object)
                    game.getLocation(location)?.contents.remove(at: objectCount)
                }
                objectCount = objectCount + 1
            }
        } else{
            print("Could not find item.")
        }
    }
    
    
    //Drop
    //This function removes an item from the player's inventory and places it in the player's location.
    func drop(item: String) {
        var foundItem = false
        for object in inventory {
            var objectCount = 0
            if object.names.contains(item) {
                game.getLocation(location)?.contents.append(object)
                inventory.remove(at: objectCount)
                foundItem = true
            }
            objectCount = objectCount + 1
        }
        if foundItem != true {
            print("Could not find item.")
        }
    }
    
    
    //Examine
    //This function gives more detailed information about an item in your inventory.
    func examine(item: String) {
        var foundItem = false
        for object in inventory {
            if object.names.contains(item) {
                print(object.description)
                foundItem = true
            }
        }
        if foundItem != true {
            print("Could not find item.")
        }
    }
}
