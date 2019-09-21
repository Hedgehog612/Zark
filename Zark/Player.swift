//
//  Player.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/19/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa

class Player {
    var inventory: [String]
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
    func get(name: String) {
        guard let item = game.getLocation(location)!.findItem(name: name) else {
            print("Item not found")
            return
        }
        game.getLocation(location)!.contents.removeAll(where: { $0 == item.id })
        inventory.append(item.id)
    }
    
    
    //Drop
    //This function removes an item from the player's inventory and places it in the player's location.
    func drop(name: String) {
        guard let item = findItem(name) else {
            print("Item not found")
            return
        }
        inventory.removeAll(where: { $0 == item.id })
        game.getLocation(location)!.contents.append(item.id)
    }
    
    
    //Examine
    //This function gives more detailed information about an item in your inventory.
    func examine(name: String) {
        guard let item = findItem(name) else {
            print("Item not found")
            return
        }
        print(item.examine)
    }
    
    
    func findItem(_ name: String) -> Item? {
        guard let item = game.getItemFromName(name) else {
            return nil
        }
        if inventory.contains(item.id) {
            return item
        } else {
            return nil
        }
    }
}
