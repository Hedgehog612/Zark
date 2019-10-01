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
class Player: Codable {
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
        location = game.world.locationFromId(locationId)
    }
    
    
    //------------------------------------------------------------------------------
    // move
    // This function moves the player between connected locations
    //------------------------------------------------------------------------------
    func move(_ direction: Direction) {
        if !location.onExit() {
            return
        }
        if let newLocation = location.connections[direction] {
            if game.world.locationFromId(newLocation).onEnter() {
                location = game.world.locationFromId(newLocation)
            }
        } else {
            print("Cannot move there")
        }
    }
    
    
    func goNorth() { move(.North) }
    func goEast()  { move(.East) }
    func goSouth() { move(.South) }
    func goWest()  { move(.West) }
    func goUp() { move(.Up) }
    func goDown() {move(.Down) }
    
    //------------------------------------------------------------------------------
    // get
    // Picks up an item and puts it in the player's inventory
    //------------------------------------------------------------------------------
    func get(item: Item) {
        if !location.containsItem(item.id) {
            print("\(item.nameList[0]) is not in this location")
            return
        }
        if !item.canPickUp {
            print("Cannot pick that up.")
            return
        }
        if item.onGet() == false {
            return
        }
        location.contents.removeAll(where: { $0 == item.id })
        inventory.append(item.id)
        item.pickedUp = true
    }
    
    
    //------------------------------------------------------------------------------
    // wait
    // does nothing
    //------------------------------------------------------------------------------
    func wait() {
        return
    }
    
    
    //------------------------------------------------------------------------------
    // drop
    // Removes an item from the player's inventory and places it in the
    // player's location.
    //------------------------------------------------------------------------------
    func drop(item: Item) {
        if item.onDrop() == false {
            return
        }
        if !inventory.contains(item.id) {
            print("You don't have the \(item.nameList[0])")
            return
        }
        inventory.removeAll(where: { $0 == item.id })
        location.contents.append(item.id)
    }
    
    
    //------------------------------------------------------------------------------
    // findItem
    // Given a name, checks if the player is carrying an item and if so,
    // returns it.
    //------------------------------------------------------------------------------
    func findItem(_ name: String) -> Item? {
        guard let item = game.world.itemFromName(name) else {
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
    // takeTurn
    //------------------------------------------------------------------------------
    func takeTurn() {
    }
    
    
    //------------------------------------------------------------------------------
    // gimme
    //------------------------------------------------------------------------------
    func gimme(item: Item) {
        inventory.append(item.id)
    }
    
    
    //------------------------------------------------------------------------------
    // teleport
    //------------------------------------------------------------------------------
    func teleport(newLocation: Location) {
        location = newLocation
    }
   
    
    //------------------------------------------------------------------------------
    // inventory
    //------------------------------------------------------------------------------
    func getInventory() {
        print("You are carrying the following items:")
        for object in inventory {
            print(game.world.itemFromId(object).nameList[0])
        }
    }
    
    
    //------------------------------------------------------------------------------
    // givingLight
    //------------------------------------------------------------------------------
    func givingLight() -> Bool {
        for item in inventory {
            if game.world.itemFromId(item).properties[.Light] == 1 {
                return true
            }
        }
        return false
    }
    
    
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    // Encoding and decoding
    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    
    
    // Our coding keys
    enum CodingKeys: String, CodingKey {
        case location
        case inventory
    }
    

    //------------------------------------------------------------------------------
    // encode
    //------------------------------------------------------------------------------
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(location.id, forKey: .location)
        try container.encode(inventory, forKey: .inventory)
    }
    

    //------------------------------------------------------------------------------
    // decode
    //------------------------------------------------------------------------------
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        location = try game.world.locationFromId(values.decode(ID.self, forKey: .location))
        inventory = try values.decode([ID].self, forKey: .inventory)
    }
    
    
    
}

//TODO:
//Two chapters
//Research UDub Bothell
//Teleport function
