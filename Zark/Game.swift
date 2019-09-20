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
    var items: [Item]
    
    init() {
        // Create the locations
        locations = [String: Location]()
        
        
        // Create the player
        player = Player(location: "lockerRoom")
        
        
        // Items
        items = []
        
        
        buildWorld()
    }
    
    
    //Build World
    //This creates all the locations in the game world and includes instructions on how to join them together. It contains instructions for placing items in their locations.
    func buildWorld() {
        addLocation(
            name: "lockerRoom",
            fullName: "Locker room",
            description: "You are in a large empty room with some lockers. To the north is a sturdy wooden door.",
            north: "briefingRoom"
        )
        
        addLocation(
            name: "briefingRoom",
            fullName: "Briefing room",
            description: "This room looks like a briefing room. There is a large table in the center of the room. To the south is a sturdy wooden door. To the east you see another room strewn with paper. To the west is a heavy airlock.",
            east: "mapRoom",
            south: "lockerRoom",
            west: "geodeRoom"
        )
        
        addLocation(
            name: "mapRoom",
            fullName: "Map room",
            description: "The walls and tables in this room are covered in maps. They appear to be mostly depicting tectonics, excavations, and other geological data. To the west, you see the briefing room.",
            west: "briefingRoom",
            contents: [Item(names: ["Key", "Large key", "Ornate key", "Large ornate key"], description: "There is a large, ornate key lying on the table.", examine: "A large metal key decorated with curves and twists of metal along its length. The teeth are equally complex and strange.")]
        )
        
        addLocation(
            name: "geodeRoom",
            fullName: "Geode room",
            description: "This room appears to be some kind of laboratory. Clean metal tables are piled high with rough, chipped rocks and cutting equipment",
            east: "briefingRoom",
            contents: [Item(names: ["Rock", "Geode", "Large rock"], description: "The largest table holds a rock the size of a pumpkin. Strewn around it are chipped, ruined saws and grinders.", examine: "You turn the rock over in your hands. It's lighter than you expected. You see a large keyhole set into one side of it.")]
        )


    }
    
    
    //Add Location
    //This function stitches together the game world and inserts items into the game world.
    func addLocation(name: String, fullName: String, description: String, north: String? = nil, east: String? = nil, south: String? = nil, west: String? = nil, northEast: String? = nil, southEast: String? = nil, southWest: String? = nil, northWest: String? = nil, contents: [Item]? = nil) {
        let location = Location(name: name, fullName: fullName, description: description, contents: contents)
        locations[name] = location
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
    
    //------------------------------------------------------------------------------
    //Get Location
    //This converts location name strings into the Location class.
    func getLocation(_ name: String) -> Location? {
        return locations[name]
    }

    
    //Commands
    //This lays out what commands the game can parse.
    let commands: [String: (Game) -> () -> ()] = [
        "north":        goNorth,
        "east":         goEast,
        "south":        goSouth,
        "west":         goWest,
        "northeast":    goNorthEast,
        "southeast":    goSouthEast,
        "southWest":    goSouthWest,
        "northWest":    goNorthWest,
        "get":          get,
    ]
    
    
    //Take Turn
    //This function handles the basic turn loop and accepts commands.
    func takeTurn() {
        print("\n")
        getLocation(player.location)!.describe()
        
        guard let input = readLine() else {
            assert(false)
            return
        }
        let parts = input.components(separatedBy: " ")
        if let function = commands[parts[0]] {
            function(self)()
        } else {
            print("Command not recognized.")
        }
    }
        
    func goNorth() {
        player.move(direction: "North")
    }
    func goEast() {
        player.move(direction: "East")
    }
    func goSouth() {
        player.move(direction: "South")
    }
    func goWest() {
        player.move(direction: "West")
    }
    func goNorthEast() {
        player.move(direction: "Northeast")
    }
    func goSouthEast() {
        player.move(direction: "Southeast")
    }
    func goSouthWest() {
        player.move(direction: "Southwest")
    }
    func goNorthWest() {
        player.move(direction: "Northwest")
    }
    func get() {
        player.get(item: parts[1])
    }
    func drop() {
        player.drop(item: parts[1])
    }
}
