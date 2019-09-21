//
//  Player.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/19/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa


//------------------------------------------------------------------------------
// Player
//------------------------------------------------------------------------------
class Player {
    var inventory: [String]
    var location: String
    
    
    //------------------------------------------------------------------------------
    // Initializer
    //------------------------------------------------------------------------------
    init(location locationIn: String) {
        inventory = []
        location = locationIn
    }
    
    
    //------------------------------------------------------------------------------
    // move
    // This function moves the player between connected locations
    //------------------------------------------------------------------------------
    func move(direction: String) {
        if let newLocation = game.locationFromId(location)!.connections[direction] {
            location = newLocation
        } else {
            print("Cannot move there")
        }
    }
    
    
    //------------------------------------------------------------------------------
    // get
    // Picks up an item and puts it in the player's inventory
    //------------------------------------------------------------------------------
    func get(name: String) {
        guard let item = game.locationFromId(location)!.itemFromName(name: name) else {
            print("Item not found")
            return
        }
        game.locationFromId(location)!.contents.removeAll(where: { $0 == item.id })
        inventory.append(item.id)
    }
    
    
    //------------------------------------------------------------------------------
    // drop
    // Removes an item from the player's inventory and places it in the
    // player's location.
    //------------------------------------------------------------------------------
    func drop(name: String) {
        guard let item = findItem(name) else {
            print("Item not found")
            return
        }
        inventory.removeAll(where: { $0 == item.id })
        game.locationFromId(location)!.contents.append(item.id)
    }
    
    
    //------------------------------------------------------------------------------
    // examine
    // Gives more detailed information about an item in your inventory.
    //------------------------------------------------------------------------------
    func examine(name: String) {
        guard let item = findItem(name) else {
            print("Item not found")
            return
        }
        print(item.examine)
    }
    
    
    //------------------------------------------------------------------------------
    // findItem
    // Given a name, checks if the player is carrying an item and if so,
    // returns it.
    //------------------------------------------------------------------------------
    func findItem(_ name: String) -> Item? {
        guard let item = game.itemFromName(name) else {
            return nil
        }
        if inventory.contains(item.id) {
            return item
        } else {
            return nil
        }
    }
}
