//
//  Game.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/19/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa


//------------------------------------------------------------------------------
// Game
//------------------------------------------------------------------------------
class Game {
    var player: Player
    var locations: [LocationID: Location]
    var items: [ItemID: Item]
    
    
    //------------------------------------------------------------------------------
    // Initializer
    //------------------------------------------------------------------------------
    init() {
        // Create the locations
        locations = [:]
        
        // Create the player
        player = Player(location: .LockerRoom)
        
        // Items
        items = [:]
        
        buildWorld()
    }
    
    
    //------------------------------------------------------------------------------
    // buildWorld
    // Creates all the locations in the game world and includes instructions
    // on how to join them together. It contains instructions for placing items in
    // their locations.
    //------------------------------------------------------------------------------
    func buildWorld() {
        // Create all the locations
        addLocation(
            id: .LockerRoom,
            fullName: "Locker room",
            roomDescription: "You are in a large empty room with some lockers. To the north is a sturdy wooden door.",
            north: .BriefingRoom
        )
        
        addLocation(
            id: .BriefingRoom,
            fullName: "Briefing room",
            roomDescription: "This room looks like a briefing room. There is a large table in the center of the room. To the south is a sturdy wooden door. To the east you see another room strewn with paper. To the west is a heavy airlock.",
            east: .MapRoom,
            south: .LockerRoom,
            west: .GeodeRoom
        )
        
        addLocation(
            id: .MapRoom,
            fullName: "Map room",
            roomDescription: "The walls and tables in this room are covered in maps. They appear to be mostly depicting tectonics, excavations, and other geological data. To the west, you see the briefing room.",
            west: .BriefingRoom,
            contents: [.Key]
            )
        
        addLocation(
            id: .GeodeRoom,
            fullName: "Geode room",
            roomDescription: "This room appears to be some kind of laboratory. Clean metal tables are piled high with rough, chipped rocks and cutting equipment",
            east: .BriefingRoom,
            contents: [.Geode]
        )


        // Create all the items
        addItem(
            id: .Key,
            nameList: ["key", "large key", "ornate key", "large ornate key"],
            roomDescription: "There is a large, ornate key lying on the table.",
            examine: "A large metal key decorated with curves and twists of metal along its length. The teeth are equally complex and strange."
        )
        
        addItem(
            id: .Geode,
            nameList: ["rock", "geode", "large rock"],
            roomDescription: "The largest table holds a rock the size of a pumpkin. Strewn around it are chipped, ruined saws and grinders.",
            examine: "You turn the rock over in your hands. It's lighter than you expected. You see a large keyhole set into one side of it."
        )
    }
    
    
    //------------------------------------------------------------------------------
    // addLocation
    // Creates a location and adds it to the world.
    //------------------------------------------------------------------------------
    func addLocation(id: LocationID, fullName: String, roomDescription: String, north: LocationID? = nil, east: LocationID? = nil, south: LocationID? = nil, west: LocationID? = nil, northEast: LocationID? = nil, southEast: LocationID? = nil, southWest: LocationID? = nil, northWest: LocationID? = nil, contents: [ItemID] = []) {
        // Create the lcoation and add it to the world
        let location = Location(id: id, fullName: fullName, roomDescription: roomDescription, contents: contents)
        locations[id] = location
        
        // Connect it to other locations
        if north != nil {
            location.connect(direction: .North, destination: north!)
        }
        if east != nil {
            location.connect(direction: .East, destination: east!)
        }
        if south != nil {
            location.connect(direction: .South, destination: south!)
        }
        if west != nil {
            location.connect(direction: .West, destination: west!)
        }
        if northEast != nil {
            location.connect(direction: .Northeast, destination: northEast!)
        }
        if southEast != nil {
            location.connect(direction: .Southeast, destination: southEast!)
        }
        if southWest != nil {
            location.connect(direction: .Southwest, destination: southWest!)
        }
        if northWest != nil {
            location.connect(direction: .Northwest, destination: northWest!)
        }
    }
    
    
    //------------------------------------------------------------------------------
    // addItem
    // Adds an item to the world
    //------------------------------------------------------------------------------
    func addItem(id: ItemID, nameList: [String], roomDescription: String, examine: String) {
        let item = Item(id: id, nameList: nameList, roomDescription: roomDescription, examine: examine)
        items[id] = item
    }
    
    
    //------------------------------------------------------------------------------
    // locationFromId
    // Gets the location with a specified id.
    //------------------------------------------------------------------------------
    func locationFromId(_ id: LocationID) -> Location? {
        return locations[id]
    }
    
    
    //------------------------------------------------------------------------------
    // itemFromId
    // Returns the item with a specified id
    //------------------------------------------------------------------------------
    func itemFromId(_ id: ItemID) -> Item? {
        return items[id]
    }
    
    
    //------------------------------------------------------------------------------
    // itemFromName
    // Returns the item with a specified human-friendly name
    //------------------------------------------------------------------------------
    func itemFromName(_ name: String) -> Item? {
        return items.values.first(where: { $0.nameList.contains(name) })
    }

    
    //------------------------------------------------------------------------------
    // commands
    // Lays out what commands the game can parse.
    //------------------------------------------------------------------------------
    let commands: [String: (Game) -> ([String]) -> ()] = [
        "north":        goNorth,
        "east":         goEast,
        "south":        goSouth,
        "west":         goWest,
        "northeast":    goNorthEast,
        "southeast":    goSouthEast,
        "southwest":    goSouthWest,
        "northwest":    goNorthWest,
        "get":          get,
        "drop":         drop,
        "examine":      examine,
    ]
    
    
    //------------------------------------------------------------------------------
    // takeTurn
    // Handles the basic turn loop and accepts commands.
    //------------------------------------------------------------------------------
    func takeTurn() {
        print("\n")
        locationFromId(player.location)!.describe()
        var input: String?
        while input == nil {
            input = readLine()
        }
        let parts = input!.lowercased().components(separatedBy: " ")
        if let function = commands[parts[0]] {
            function(self)(Array(parts[1...]))
        } else {
            print("Command not recognized.")
        }
    }
    
    
    //------------------------------------------------------------------------------
    // Command handlers. These are mostly just stubs.
    //------------------------------------------------------------------------------
    func goNorth(args: [String]) {
        player.move(direction: .North)
    }
    func goEast(args: [String]) {
        player.move(direction: .East)
    }
    func goSouth(args: [String]) {
        player.move(direction: .South)
    }
    func goWest(args: [String]) {
        player.move(direction: .West)
    }
    func goNorthEast(args: [String]) {
        player.move(direction: .Northeast)
    }
    func goSouthEast(args: [String]) {
        player.move(direction: .Southeast)
    }
    func goSouthWest(args: [String]) {
        player.move(direction: .Southwest)
    }
    func goNorthWest(args: [String]) {
        player.move(direction: .Northwest)
    }
    func get(args: [String]) {
        player.get(name: args[0])
    }
    func drop(args: [String]) {
        player.drop(name: args[0])
    }
    func examine(args: [String]) {
        player.examine(name: args[0])
    }
}
