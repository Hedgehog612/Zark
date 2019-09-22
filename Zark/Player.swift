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
    func setLocation(_ locationId: LocationID) {
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
    func itemInInventory(_ itemID: ItemID) -> Bool {
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
        switch item.id {
        case .Key: useKey()
        case .Button: useButton()
        default:
            print("You can't do anything special with the \(item.nameList[0]).")
        }
    }
    
    
    //------------------------------------------------------------------------------
    // useKey
    //------------------------------------------------------------------------------
    func useKey() {
        if location.containsItem(.Door) {
            if game.itemFromId(.Door).properties[.Unlocked] == 1 {
                print("The door is already unlocked.")
                return
            }
            game.locationFromId(.BriefingRoom).connect(direction: .North, destination: .ViewingRoom)
            print("You insert the key into the lock and turn. The door swings open.")
            game.itemFromId(.Door).roomDescription = "The northern door stands open."
            game.itemFromId(.Door).properties[.Unlocked] = 1
        } else {
            print("There isn't anything to use the key on here.")
        }
        
        if myLocation().containsItem(.Geode) {
            if game.itemFromId(.Door).properties[.Unlocked] == 1 {
                print("The geode is already unlocked.")
                return
            }
            game.locationFromId(.GeodeRoom).contents = [.Crystal]
            print("You insert the key into the rock and turn. The rock splits into two pieces. Inside, you see shining purple crystals lining the walls of the geode.")
            game.itemFromId(.Geode).properties[.Unlocked] = 1
        }
    }
    
    
    //------------------------------------------------------------------------------
    // useButton
    //------------------------------------------------------------------------------
    func useButton() {
        if myLocation().containsItem(.Button) {
            print("You press the button. Nothing seems to happen.")
            if game.itemFromId(.Lamp).properties[.Light] == 0 {
                game.itemFromId(.Lamp).properties[.Light] = 1
                game.locationFromId(.DarkRoom).connect(direction: .West, destination: .ArchiveRoom)
                game.locationFromId(.DarkRoom).roomDescription = "You stand in a cramped corridor that runs east to west."
                game.itemFromId(.Lamp).roomDescription = "A brightly shining lamp rests on the ground."
                return
            } else {
                game.itemFromId(.Lamp).properties[.Light] = 0
                game.locationFromId(.DarkRoom).connections = [.East : .ViewingRoom]
                game.locationFromId(.DarkRoom).roomDescription = "You stand in a cramped corridor that runs east to west."
                game.itemFromId(.Lamp).roomDescription = "An unlit lamp rests on the ground."
            }
        }
    }
    
}


