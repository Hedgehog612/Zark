//
//  Game.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/19/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa

class Game {
    var player: Player
    var locations: [String: Location]
    var items: [String: Item]
    
    init() {
        // Create the locations
        locations = [String: Location]()
        
        
        // Create the player
        player = Player(location: "lockerRoom")
        
        
        // Items
        items = [:]
        
        
        buildWorld()
    }
    
    
    //Build World
    //This creates all the locations in the game world and includes instructions on how to join them together. It contains instructions for placing items in their locations.
    func buildWorld() {
        addLocation(
            id: "lockerRoom",
            fullName: "Locker room",
            roomDescription: "You are in a large empty room with some lockers. To the north is a sturdy wooden door.",
            north: "briefingRoom"
        )
        
        addLocation(
            id: "briefingRoom",
            fullName: "Briefing room",
            roomDescription: "This room looks like a briefing room. There is a large table in the center of the room. To the south is a sturdy wooden door. To the east you see another room strewn with paper. To the west is a heavy airlock.",
            east: "mapRoom",
            south: "lockerRoom",
            west: "geodeRoom"
        )
        
        addLocation(
            id: "mapRoom",
            fullName: "Map room",
            roomDescription: "The walls and tables in this room are covered in maps. They appear to be mostly depicting tectonics, excavations, and other geological data. To the west, you see the briefing room.",
            west: "briefingRoom",
            contents: ["key"]
            )
        
        addLocation(
            id: "geodeRoom",
            fullName: "Geode room",
            roomDescription: "This room appears to be some kind of laboratory. Clean metal tables are piled high with rough, chipped rocks and cutting equipment",
            east: "briefingRoom",
            contents: ["geode"]
        )


        addItem(
            id: "key",
            nameList: ["key", "large key", "ornate key", "large ornate key"],
            roomDescription: "There is a large, ornate key lying on the table.",
            examine: "A large metal key decorated with curves and twists of metal along its length. The teeth are equally complex and strange."
        )
        
        addItem(
            id: "geode",
            nameList: ["rock", "geode", "large rock"],
            roomDescription: "The largest table holds a rock the size of a pumpkin. Strewn around it are chipped, ruined saws and grinders.",
            examine: "You turn the rock over in your hands. It's lighter than you expected. You see a large keyhole set into one side of it."
        )
    }
    
    
    //Add Location
    //This function stitches together the game world and inserts items into the game world.
    func addLocation(id: String, fullName: String, roomDescription: String, north: String? = nil, east: String? = nil, south: String? = nil, west: String? = nil, northEast: String? = nil, southEast: String? = nil, southWest: String? = nil, northWest: String? = nil, contents: [String] = []) {
        let location = Location(id: id, fullName: fullName, roomDescription: roomDescription, contents: contents)
        locations[id] = location
        if north != nil {
            location.connect(direction: "North", destination: north!)
        }
        if east != nil {
            location.connect(direction: "East", destination: east!)
        }
        if south != nil {
            location.connect(direction: "South", destination: south!)
        }
        if west != nil {
            location.connect(direction: "West", destination: west!)
        }
        if northEast != nil {
            location.connect(direction: "Northeast", destination: northEast!)
        }
        if southEast != nil {
            location.connect(direction: "Southeast", destination: southEast!)
        }
        if southWest != nil {
            location.connect(direction: "Southwest", destination: southWest!)
        }
        if northWest != nil {
            location.connect(direction: "northWest", destination: northWest!)
        }
    }
    
    
    func addItem(id: String, nameList: [String], roomDescription: String, examine: String) {
        let item = Item(id: id, nameList: nameList, roomDescription: roomDescription, examine: examine)
        items[id] = item
    }
    
    //------------------------------------------------------------------------------
    //Get Location
    //This converts location name strings into the Location class.
    func getLocation(_ id: String) -> Location? {
        return locations[id]
    }
    
    
    func getItem(_ id: String) -> Item? {
        return items[id]
    }
    
    
    func getItemFromName(_ name: String) -> Item? {
        return items.values.first(where: { $0.nameList.contains(name) })
    }

    
    //Commands
    //This lays out what commands the game can parse.
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
    
    
    //Take Turn
    //This function handles the basic turn loop and accepts commands.
    func takeTurn() {
        print("\n")
        getLocation(player.location)!.describe()
        
        guard let input = readLine() else {
            return
        }
        let parts = input.lowercased().components(separatedBy: " ")
        if let function = commands[parts[0]] {
            function(self)(Array(parts[1...]))
        } else {
            print("Command not recognized.")
        }
    }
        
    func goNorth(args: [String]) {
        player.move(direction: "North")
    }
    func goEast(args: [String]) {
        player.move(direction: "East")
    }
    func goSouth(args: [String]) {
        player.move(direction: "South")
    }
    func goWest(args: [String]) {
        player.move(direction: "West")
    }
    func goNorthEast(args: [String]) {
        player.move(direction: "Northeast")
    }
    func goSouthEast(args: [String]) {
        player.move(direction: "Southeast")
    }
    func goSouthWest(args: [String]) {
        player.move(direction: "Southwest")
    }
    func goNorthWest(args: [String]) {
        player.move(direction: "Northwest")
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
