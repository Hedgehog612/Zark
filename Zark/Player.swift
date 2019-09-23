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
    var inventory: [ID]
    var location: Location!
    
    
    //------------------------------------------------------------------------------
    // Initializer
    //------------------------------------------------------------------------------
    init() {
        inventory = []
    }
    
    
    //------------------------------------------------------------------------------
    // setLocation
    // Move us to a specified location.
    //------------------------------------------------------------------------------
    func setLocation(_ locationId: ID) {
        location = game.locationFromId(locationId)
    }
    
    
    //------------------------------------------------------------------------------
    // move
    // This function moves the player between connected locations
    //------------------------------------------------------------------------------
    func move(direction: Direction) {
        if let newLocation = location.connections[direction] {
            location = game.locationFromId(newLocation)
        } else {
            print("Cannot move there")
        }
    }
    
    
    //------------------------------------------------------------------------------
    // get
    // Picks up an item and puts it in the player's inventory
    //------------------------------------------------------------------------------
    func get(name: String) {
        guard let item = location.itemFromName(name: name) else {
            print("Item not found")
            return
        }
        if !item.canPickUp {
            print("Cannot pick that up.")
        } else {
            location.contents.removeAll(where: { $0 == item.id })
            inventory.append(item.id)
            item.pickedUp = true
        }
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
        location.contents.append(item.id)
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
    
    
    //------------------------------------------------------------------------------
    // itemInInventory
    // Returns true/false based on if the item is in inventory.
    //------------------------------------------------------------------------------
    func itemInInventory(_ itemID: ID) -> Bool {
        return inventory.contains(itemID)
    }
    
    
    //------------------------------------------------------------------------------
    // use
    //------------------------------------------------------------------------------
    func use(name: String) {
        guard let item = game.itemFromName(name) else {
            print("This isn't an item")
            return
        }
        if !location.containsItem(item.id) && !itemInInventory(item.id) {
            print("I don't see the \(item.nameList[0]) here.")
            return
        }
        item.use()
    }
}


