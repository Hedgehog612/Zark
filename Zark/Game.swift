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
    var locations: [ID: Location]
    var items: [ID: Item]
    
    
    //------------------------------------------------------------------------------
    // Initializer
    //------------------------------------------------------------------------------
    init() {
        // Create the locations
        locations = [:]
        
        // Create the player
        player = Player()
        
        // Items
        items = [:]
    }
    
    
    //------------------------------------------------------------------------------
    // buildWorld
    // Creates all the locations in the game world and includes instructions
    // on how to join them together. It contains instructions for placing items in
    // their locations.
    //------------------------------------------------------------------------------
    func buildWorld() {
        //------------------------------------------------------------------------------
        // Create all the locations
        //------------------------------------------------------------------------------
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
            west: .GeodeRoom,
            contents: [.Door]
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
            roomDescription: "This room appears to be some kind of laboratory. Clean metal tables are piled high with rough, chipped rocks and cutting equipment.",
            east: .BriefingRoom,
            contents: [.Geode]
        )
        
        
        addLocation(
            id: .MoonRoom,
            fullName: "Moon Pool room",
            roomDescription: "This circular room contains a thin walkway around a large pool, which occupies the majority of the space. Lights shine into the water, and you can faintly see the ocean floor through the water."
        )
        
        
        addLocation(
            id: .ViewingRoom,
            fullName: "Viewing Room",
            roomDescription: "The north side of this room is one clear glass wall. Outside, you see a sprawling growth of coral. Occasionally, a fish flits by.",
            south: .BriefingRoom,
            west: .DarkRoom,
            contents: [.Button]
        )
        
        
        addLocation(
            id: .DarkRoom,
            fullName: "Dark Room",
            roomDescription: "The corridor ahead of you is pitch-black. You can't see any futher.",
            east: .ViewingRoom,
            contents: [.Lamp]
        )
        
        
        addLocation(
            id: .ArchiveRoom,
            fullName: "Archive Room",
            roomDescription: "This room is crammed with records and files. They overflow from cabinets and spill across the ground.",
            east: .DarkRoom,
            contents: [.Lantern]
        )


        //------------------------------------------------------------------------------
        // Create all the items
        //------------------------------------------------------------------------------
        addItem(Key(
            id: .Key,
            nameList: ["key", "large key", "ornate key", "large ornate key"],
            roomDescription: "There is a large, ornate key lying on the table.",
            dropDescription: "There is a large, ornate key here.",
            examine: "A large metal key decorated with curves and twists of metal along its length. The teeth are equally complex and strange."
        ))
        
        addItem(Item(
            id: .Geode,
            nameList: ["rock", "large rock"],
            roomDescription: "The largest table holds a rock the size of a pumpkin. Strewn around it are chipped, ruined saws and grinders. You see a large keyhole set into one side of it.",
            dropDescription: "There is a large rock here.",
            examine: "You turn the rock over in your hands. It's lighter than you expected. You see a large keyhole set into one side of it.",
            canPickUp: false
        ))
        
        addItem(Item(
            id: .Door,
            nameList: ["door"],
            roomDescription: "There is a sturdy, locked door set into the north wall.",
            dropDescription: "",
            examine: "",
            canPickUp: false,
            properties: [.Unlocked : 0]
        ))
        
        
        addItem(Lantern(
            id: .Lantern,
            nameList: ["lantern"],
            roomDescription: "There is an old lantern here.",
            dropDescription: "There is an old lantern here.",
            examine: "You examine the lantern. Oil level reference.",
            canPickUp: true,
            properties: [.Fuel : 10, .On : 0]
        ))
        
        
        addItem(Item(
            id: .Lamp,
            nameList: ["lamp"],
            roomDescription: "An unlit lamp rests on the ground. ",
            dropDescription: "",
            examine: "",
            canPickUp: false,
            properties: [.Light : 0]
        ))
        
        
        addItem(Button(
            id: .Button,
            nameList: ["button"],
            roomDescription: "There's a blue button on the west wall. ",
            dropDescription: "",
            examine: "",
            canPickUp: false
        ))
        
        
        addItem(Item(
            id: .Crystal,
            nameList: ["crystal"],
            roomDescription: "A purple crystal the size of your hand rests in one hemisphere of the geode. ",
            dropDescription: "There is a purple crystal here.",
            examine: "The crystal is beautiful, many-faceted, and shining.",
            properties: [.Unlocked : 0]
        ))
        
        
        //------------------------------------------------------------------------------
        // Set up the player
        //------------------------------------------------------------------------------
        player.setLocation(.LockerRoom)
    }
    
    
    //------------------------------------------------------------------------------
    // addLocation
    // Creates a location and adds it to the world.
    //------------------------------------------------------------------------------
    func addLocation(id: ID, fullName: String, roomDescription: String, north: ID? = nil, east: ID? = nil, south: ID? = nil, west: ID? = nil, northEast: ID? = nil, southEast: ID? = nil, southWest: ID? = nil, northWest: ID? = nil, contents: [ID] = [], properties: [PropertyId: Int] = [:]) {
        // Create the lcoation and add it to the world
        let location = Location(id: id, fullName: fullName, roomDescription: roomDescription, contents: contents, properties: properties)
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
    func addItem(_ item: Item) {
        items[item.id] = item
    }
    
    
    //------------------------------------------------------------------------------
    // locationFromId
    // Gets the location with a specified id.
    //------------------------------------------------------------------------------
    func locationFromId(_ id: ID) -> Location {
        return locations[id]!
    }
    
    
    //------------------------------------------------------------------------------
    // itemFromId
    // Returns the item with a specified id
    //------------------------------------------------------------------------------
    func itemFromId(_ id: ID) -> Item {
        return items[id]!
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
        "grab":         get,
        "drop":         drop,
        "dump":         drop,
        "examine":      examine,
        "look at":      examine,
        "use":          use,
    ]
    
    
    //------------------------------------------------------------------------------
    // takeTurn
    // Handles the basic turn loop and accepts commands.
    //------------------------------------------------------------------------------
    func takeTurn() {
        print("\n")
        player.location.describe()
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
        
        for item in items.values {
            item.takeTurn()
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
    func use(args: [String]) {
        player.use(name: args[0])
    }
}
