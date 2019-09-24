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
        addLocation(Location(
            id: .LockerRoom,
            fullName: "Locker room",
            roomDescription: "You are in a large empty room with some lockers. To the north is a sturdy wooden door.",
            north: .BriefingRoom
        ))
        
        addLocation(Location(
            id: .BriefingRoom,
            fullName: "Briefing room",
            roomDescription: "This room looks like a briefing room. There is a large table in the center of the room. To the south is a sturdy wooden door. To the east you see another room strewn with paper. To the west is a heavy airlock.",
            east: .MapRoom,
            south: .LockerRoom,
            west: .GeodeRoom,
            contents: [.Door]
        ))
        
        addLocation(Location(
            id: .MapRoom,
            fullName: "Map room",
            roomDescription: "The walls and tables in this room are covered in maps. They appear to be mostly depicting tectonics, excavations, and other geological data. To the west, you see the briefing room.",
            west: .BriefingRoom,
            contents: [.Key]
            ))
        
        addLocation(Location(
            id: .GeodeRoom,
            fullName: "Geode room",
            roomDescription: "This room appears to be some kind of laboratory. Clean metal tables are piled high with rough, chipped rocks and cutting equipment.",
            east: .BriefingRoom,
            contents: [.Geode]
        ))
        
        
        addLocation(Location(
            id: .MoonRoom,
            fullName: "Moon Pool room",
            roomDescription: "This circular room contains a thin walkway around a large pool, which occupies the majority of the space. Lights shine into the water, and you can faintly see the ocean floor through the water."
        ))
        
        
        addLocation(Location(
            id: .ViewingRoom,
            fullName: "Viewing Room",
            roomDescription: "The north side of this room is one clear glass wall. Outside, you see a sprawling growth of coral. Occasionally, a fish flits by.",
            south: .BriefingRoom,
            west: .DarkRoom,
            contents: [.Button]
        ))
        
        
        addLocation(Location(
            id: .DarkRoom,
            fullName: "Dark Room",
            roomDescription: "The corridor ahead of you is pitch-black. You can't see any futher.",
            east: .ViewingRoom,
            contents: [.Lamp]
        ))
        
        
        addLocation(Location(
            id: .ArchiveRoom,
            fullName: "Archive Room",
            roomDescription: "This room is crammed with records and files. They overflow from cabinets and spill across the ground.",
            east: .DarkRoom,
            contents: [.Lantern]
        ))


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
            canPickUp: false,
            properties: [.Unlocked : 0]
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
    func addLocation(_ location: Location) {
        locations[location.id] = location
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
    
    typealias CommandTemplate = (String, ((Player) -> (Item?) -> ())?, ((Item) -> (Item?) ->())?)
    
    let commands: [CommandTemplate] = [
        ("north",                       Player.goNorth,      nil),
        ("go north",                    Player.goNorth,      nil),
        ("n",                           Player.goNorth,      nil),
        ("east",                        Player.goEast,       nil),
        ("go east",                     Player.goEast,       nil),
        ("e",                           Player.goEast,       nil),
        ("west",                        Player.goWest,       nil),
        ("go west",                     Player.goWest,       nil),
        ("w",                           Player.goWest,       nil),
        ("south",                       Player.goSouth,      nil),
        ("go south",                    Player.goSouth,      nil),
        ("s",                           Player.goSouth,      nil),
        ("get $item1",                  Player.get,          nil),
        ("take $item1",                 Player.get,          nil),
        ("use $item1",                  nil,                 Item.use),
        ("examine $item1",              nil,                 Item.examine),
        ("pick up $item1",              Player.get,          nil),
        ("unlock $item2 with $item1",   nil,                 Item.use),
        ("open $item2 with $item1",     nil,                 Item.use),
        ("use $item1 on $item2",        nil,                 Item.use),
        ("drop $item1",                 Player.drop,         nil)
        ]

    //------------------------------------------------------------------------------
    // takeTurn
    // Handles the basic turn loop and accepts commands.
    //------------------------------------------------------------------------------
    func takeTurn() {
        // Where are we?
        print("\n")
        player.location.describe()
        
        // Get a valid input string.
        // For unknown reasons, this occasionally returns nil, so keep hittin it until
        // we get something sensible.
        var input: String?
        while input == nil {
            input = readLine()
        }
        
        var item1: Item?
        var item2: Item?
        
        // Try every command template in turn and see if it matches the input line
        commandLoop: for (template, playerfunc, itemfunc) in commands {
            // Make a copy of the input that we can eat as we match parts of it
            var workingInput = input!.lowercased()
            
            // We're going to process the template word by word. Note that one word
            // of the template may match several words in the input.
            var templateParts = template.components(separatedBy: " ")
            
            // Keep matching template words until it's all used up
            matchLoop: while !templateParts.isEmpty && !workingInput.isEmpty {
                let currentPart = templateParts[0]
                while workingInput.first == " " {
                    workingInput.remove(at: workingInput.startIndex)
                }
                
                // If the template word doesn't begin with $, it needs an exact match
                if !currentPart.hasPrefix("$") {
                    if workingInput.hasPrefix(currentPart) {
                        workingInput.removeFirst(templateParts[0].count)
                        templateParts.remove(at:0)
                        continue matchLoop
                    } else {
                        continue commandLoop
                    }
                }
                
                //This checks all possible names you can refer to all items by
                for item in items.values {
                    for name in item.nameList {
                        
                        //Found a match, remove matching section
                        if workingInput.hasPrefix(name) {
                            if currentPart == "$item1" {
                                item1 = item
                            } else {
                                item2 = item
                            }
                            workingInput.removeFirst(name.count)
                            templateParts.remove(at:0)
                            continue matchLoop
                        }
                    }
                }
            }
            
            // One of the strings is empty. Hopefully they both are.
            if !templateParts.isEmpty || !workingInput.isEmpty {
                continue commandLoop
            }
            
            // We found a match. Execute it
            if playerfunc != nil {
                playerfunc!(player)(item1)
            } else {
                assert(itemfunc != nil)
                assert(item1 != nil)
                itemfunc!(item1!)(item2)
            }
            return
        }
        
        // No match
        print("Error: could not find a matching command")
    }
}
