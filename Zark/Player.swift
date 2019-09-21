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
    var inventory: [ItemID]
    var location: LocationID
    
    
    //------------------------------------------------------------------------------
    // Initializer
    //------------------------------------------------------------------------------
    init(location locationIn: LocationID) {
        inventory = []
        location = locationIn
    }
    
    
    //------------------------------------------------------------------------------
    // move
    // This function moves the player between connected locations
    //------------------------------------------------------------------------------
    func move(direction: Direction) {
        if let newLocation = game.locationFromId(location).connections[direction] {
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
        guard let item = game.locationFromId(location).itemFromName(name: name) else {
            print("Item not found")
            return
        }
        if !item.canPickUp {
            print("Cannot pick that up.")
        } else {
            game.locationFromId(location).contents.removeAll(where: { $0 == item.id })
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
        game.locationFromId(location).contents.append(item.id)
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
    func itemInInventory(_ itemID: ItemID) -> Bool {
        return inventory.contains(itemID)
    }
    
    
    //------------------------------------------------------------------------------
    // My location
    //
    //------------------------------------------------------------------------------
    func myLocation() -> Location {
        return game.locationFromId(location)
    }
    
    
    //------------------------------------------------------------------------------
    // use
    //------------------------------------------------------------------------------
    func use(name: String) {
        guard let item = game.itemFromName(name) else {
            print("This isn't an item")
            return
        }
        if !game.locationFromId(location).containsItem(item.id) && !itemInInventory(item.id) {
            print("I don't see the \(item.nameList[0]) here.")
            return
        }
        switch item.id {
        case .Key: useKey()
            
        default:
            print("You can't do anything special with the \(item.nameList[0]).")
        }
    }
    
    
    //------------------------------------------------------------------------------
    // useKey
    //------------------------------------------------------------------------------
    func useKey() {
        if myLocation().containsItem(.Door) {
            if game.itemFromId(.Door).properties[.Unlocked] == 1 {
                print("The door is already unlocked.")
                return
            }
            game.locationFromId(.BriefingRoom).connect(direction: .North, destination: .ViewingRoom)
            print("You insert the key into the lock and turn. The door swings open.")
            game.itemFromId(.Door).roomDescription = "The northern door stands open."
            game.itemFromId(.Door).properties[.Unlocked] = 1
        }
    }
}


