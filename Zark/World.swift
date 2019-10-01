//
//  World.swift
//  Zark
//
//  Created by Marcus Bamberger on 10/1/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa

class World: Codable {
    var player: Player
    var locations: [ID: Location]
    var items: [ID: Item]
    var creatures: [ID: Creature]
    
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
        
        //Creatures
        creatures = [:]
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
            id: .HospitalRoom,
            fullName: "Hospital room",
            roomDescription: "You stand in a room that smells of plastic and blood. There's a few hospital gurneys pushed into the corners of the roomand packed with bandages, gloves, and other simple medical supplies. The bed you woke up in rests in the middle of the room. You see cramped corridors leading out of the room to the north, south, and east. You see an open hatch in one corner with a ladder that leads down into a dark room. TODO: examine bed",
            north: .BriefingRoom,
            east: .SupplyRoom,
            south: .ScuffleRoom,
            down: .DarkEntranceRoom
        ))
        
        addLocation(Location(
            id: .SupplyRoom,
            fullName: "Supply room",
            roomDescription: "This room is packed with cabinets and crates. They're all open and empty, and the torn plastic packaging littering the floor suggests that the room was emptied in a hurry. To the west, you see the makeshift hospital you wokr up in. There's another door on the south wall. TODO: examine crates/cabinets.",
            south: .LogRoom,
            west: .HospitalRoom
        ))
        
        addLocation(Location(
            id: .LogRoom,
            fullName: "Log room",
            roomDescription: "You find yourself in a tight corridor that curves sharply, turning a full ninety degrees in just a few meters. As you navigate the turn, your foot lands in something wet. The ceiling here is leaking a steady flow of water into a puddle at your feet. The corridor continues to the north and west. TODO: Add log, examine water.",
            north: .SupplyRoom,
            west: .ScuffleRoom
        ))
        
        addLocation(Location(
            id: .ScuffleRoom,
            fullName: "Scuffle room",
            roomDescription: "This looks like the room you woke up in. Another open area that could have been a break room, perhaps, turned into a crude hospital. Here, however, is chaos. You see upended beds, smashed bottles, and the occasional smear of blood. You step through a carpet of debris as you check the exits to your north and east. TODO: Examine debris.",
            north: .HospitalRoom,
            east: .LogRoom
        ))
        
        addLocation(Location(
            id: .DarkEntranceRoom,
            fullName: "Dark entrance room",
            roomDescription: "The lights set into the walls everywhere else in this place have gone out on this level. The only light is what shines down from the hatch leading up to the hospital room. You can faintly make out the words, 'Engine Deck' painted in large white letters on the wall, but little else. To the north, a corridor extends into darkness.",
            north: .BoilerRoom,
            up: .HospitalRoom
        ))
        
        addLocation(Location(
            id: .BoilerRoom,
            fullName: "Boiler Room",
            roomDescription: "If not for your flickering lantern, you'd be completely blind in here. You're on a catwalk that extends through the air above massive machines you cannot identify. The ceiling is cramped and low, but if you fell, you'd be falling a long way. The catwalk splits four ways ahead of you. You can continue to the north, south, east, or west.",
            north: .CatwalkOutRoom,
            east: .MonitoringStationRoom,
            south: .DarkEntranceRoom,
            west: .SplitRoom,
            properties: [.Dark : 1]
        ))
        
        addLocation(Location(
            id: .MonitoringStationRoom,
            fullName: "MonitoringStationRoom",
            roomDescription: "You've reached some kind of monitoring station for the equipment down here. A few of the consoles are still running, but the majority are dark and unresponsive. There are two doors to the north and west.",
            north: .EngineRoom,
            west: .BoilerRoom,
            properties: [.Dark : 1]
        ))
        
        addLocation(Location(
            id: .SplitRoom,
            fullName: "Split Room",
            roomDescription: "You've reached one side of the large, open engine deck. The catwalk curves away from you to the north and east. At the edge of the lantern-light, something catches your eye. A tangle of thick, black cables spill off the catwalk to the northwest, curving down and back up to the engine deck's wall, almost twenty feet away. It almost looks like there's a platform over there...",
            north: .ObservationDeckRoom,
            east: .BoilerRoom,
            northEast: .PlatformRoom,
            properties: [.Dark : 1]
        ))
        
        addLocation(Location(
            id: .PlatformRoom,
            fullName: "Platform room",
            roomDescription: "You managed to crawl across the cables without dropping your lantern. The only thing more surprising than your choice of action is that, apparantly, you weren't the first person to do this. Someone's built a small metal platform, just wide enough to lie down on, on the port that connects the cables to this wall. Those cables extend back to the catwalk to the northeast and southeast. It's too far down to jump, so it looks like that's your only option. TODO: examine supplies, add gun.",
            northEast: .ObservationDeckRoom,
            southEast: .SplitRoom,
            properties: [.Dark : 1]
        ))
        
        addLocation(Location(
            id: .ObservationDeckRoom,
            fullName: "Observation Deck room",
            roomDescription: "You've reached the edge of the catwalks. Looking down, you can see that the engine room extends further to the north, but this catwalk terminates at a door that leads into a set of rooms suspended over the engine deck. The catwalk continues to the south and east. A tangle of cables extends away from the catwalk to the southwest. They might be climbable.",
            north: .EngineOfficeRoom,
            east: .CatwalkOutRoom,
            south: .SplitRoom,
            southWest: .PlatformRoom,
            properties: [.Dark : 1]
        ))
        
        addLocation(Location(
            id: .CatwalkOutRoom,
            fullName: "Catwalk Out Room",
            roomDescription: "This catwalk comes to another intersection, but the catwalk to the north has collapsed. The remaining three - to the east, west, and south - are still intact. TODO: Examine catwalk",
            east: .EngineRoom,
            south: .BoilerRoom,
            west: .ObservationDeckRoom,
            properties: [.Dark : 1]
        ))
        
        addLocation(Location(
            id: .EngineRoom,
            fullName: "Engine Room",
            roomDescription: "The engines in this room are still running, emitting a steady dull pulse. The catwalk you're on extends out to the north, south, and west. To the east, you see the catwalk extend to a door on the wall.",
            north: .EngineNorthRoom,
            east: .SealedExitRoom,
            south: .MonitoringStationRoom,
            west: .EngineRoom,
            properties: [.Dark : 1]
        ))
        
        addLocation(Location(
            id: .SealedExitRoom,
            fullName: "Sealed Exit Room",
            roomDescription: "You've reached another ladder leading up, but the hatch above you is sealed tight. To your west is the engine deck.",
            west: .EngineRoom,
            properties: [.Dark : 1]
        ))
        
        addLocation(Location(
            id: .EngineNorthRoom,
            fullName: "Engine North Room",
            roomDescription: "You've reached the northern edge of the catwalks. To the south lies the majority of the catwalk space. To the west, the catwalk joins a small set of rooms suspended over the engines.",
            south: .EngineRoom,
            west: .EngineOfficeRoom,
            properties: [.Dark : 1]
        ))
        
        addLocation(Location(
            id: .EngineOfficeRoom,
            fullName: "Engine Office Room",
            roomDescription: "This seems to be a small office space for administrating the engines. The room is filled with desks piled with paperwork. To the north is a door to what looks like a fancier office. There are exits to the south and east.",
            north: .OfficeRoom,
            east: .EngineNorthRoom,
            south: .ObservationDeckRoom,
            properties: [.Dark : 1]
        ))
        
        addLocation(Location(
            id: .OfficeRoom,
            fullName: "Engine Office Room",
            roomDescription: "This room is occupied by a massive wooden desk, stacked with papers. There's a window looking down on the engines on the north wall. The exit to the office space is behind you, to the south. TODO: Add map.",
            south: .EngineOfficeRoom,
            contents: [.Map],
            properties: [.Dark : 1]
        ))
        
        addLocation(Location(
            id: .BriefingRoom,
            fullName: "Briefing room",
            roomDescription: "This room looks like a briefing room. There is a large table in the center of the room. To the south is a sturdy wooden door. To the east you see another room strewn with paper. To the west is a heavy airlock.",
            east: .MapRoom,
            south: .HospitalRoom,
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
            east: .TunnelOneRoom,
            south: .BriefingRoom,
            west: .DarkRoom
        ))
        
        addLocation(Location(
            id: .TunnelOneRoom,
            fullName: "Tunnel One Room",
            roomDescription: "You stand in a long, glass corridor running east to west. Outside, you can see fish swimbing by. To the south, you see more of the habitat you've been moving through.",
            east: .TunnelTwoRoom,
            west: .ViewingRoom
        ))
        
        addLocation(Location(
            id: .TunnelTwoRoom,
            fullName: "Tunnel Two Room",
            roomDescription: "You stand in a long, glass corridor running east to west. Outside, you can see fish swimbing by. To the south, you see more of the habitat you've been moving through. You can tell that this is just one wing of a much larger complex that extends out to the east.",
            east: .GeneratorRoom,
            west: .TunnelOneRoom
        ))
        
        addLocation(Location(
            id: .GeneratorRoom,
            fullName: "GeneratorRoom",
            roomDescription: "At the end of the corridor, you find what you think is a console to power lights in the facility. Most of the console is offline, but one blue button still blinks.",
            west: .TunnelTwoRoom,
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
            id: .ArchiveCERoom,
            fullName: "Archive CE Room",
            roomDescription: "This room is crammed with records and files. They overflow from cabinets and spill across the ground.",
            north: .ArchiveCNRoom,
            east: .DarkRoom,
            west: .ArchiveNERoom,
            contents: [.Lantern]
        ))
        
        addLocation(Location(
            id: .ArchiveNERoom,
            fullName: "Archive NE Room",
            roomDescription: "This room is crammed with records and files. They overflow from cabinets and spill across the ground.",
            north: .ArchiveNNRoom,
            east: .ArchiveCERoom,
            west: .ArchiveLERoom
        ))
        
        addLocation(Location(
            id: .ArchiveLERoom,
            fullName: "Archive LE Room",
            roomDescription: "This room is crammed with records and files. They overflow from cabinets and spill across the ground.",
            north: .OrcRoom,
            east: .ArchiveNERoom
        ))
        
        addLocation(Location(
            id: .ArchiveCNRoom,
            fullName: "Archive CN Room",
            roomDescription: "This room is crammed with records and files. They overflow from cabinets and spill across the ground.",
            north: .ArchiveCGRoom,
            south: .ArchiveCERoom,
            west: .ArchiveNNRoom
        ))
        
        addLocation(Location(
            id: .ArchiveNNRoom,
            fullName: "Archive NN Room",
            roomDescription: "This room is crammed with records and files. They overflow from cabinets and spill across the ground.",
            north: .ArchiveNGRoom,
            east: .ArchiveCNRoom,
            south: .ArchiveNERoom,
            west: .OrcRoom
        ))
        
        addLocation(Location(
            id: .OrcRoom,
            fullName: "Archive LN Room",
            roomDescription: "This room is crammed with records and files. They overflow from cabinets and spill across the ground.",
            north: .ArchiveLGRoom,
            east: .ArchiveNGRoom,
            south: .ArchiveLERoom
        ))
        
        addLocation(Location(
            id: .ArchiveNGRoom,
            fullName: "Archive NG Room",
            roomDescription: "This room is crammed with records and files. They overflow from cabinets and spill across the ground.",
            east: .ArchiveCGRoom,
            south: .ArchiveNNRoom,
            west: .ArchiveLGRoom,
            contents: [.Keycard]
        ))
        
        addLocation(Location(
            id: .ArchiveCGRoom,
            fullName: "Archive CG Room",
            roomDescription: "This room is crammed with records and files. They overflow from cabinets and spill across the ground.",
            south: .ArchiveCNRoom,
            west: .ArchiveNGRoom
        ))


        //------------------------------------------------------------------------------
        // Create all the items
        //------------------------------------------------------------------------------
        addItem(Key(
            id: .Key,
            nameList: ["key", "large key", "ornate key", "large ornate key"],
            roomDescription: "There is a large, ornate key lying on the table.",
            dropDescription: "There is a large, ornate key here.",
            examine: "A large metal key decorated with curves and twists of metal along its length. The teeth are equally complex and strange.",
            properties: [.Hot : 1]
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
            properties: [.Fuel : 30, .Light : 0]
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
        
        addItem(Item(
            id: .Map,
            nameList: ["map"],
            roomDescription: "A map is spread out across the table. ",
            dropDescription: "There is a map here.",
            examine: "This seems to show the facility you've been exploring.",
            properties: [.Unlocked : 0]
        ))
        
        addItem(Item(
            id: .Keycard,
            nameList: ["keycard"],
            roomDescription: "In the middle of the archives, you spot a blue keycard lying on top of some files.",
            dropDescription: "There is a keycard here.",
            examine: "It's a plain blue keycard with a magnetic stripe.",
            properties: [.Unlocked : 0]
        ))
        
        //------------------------------------------------------------------------------
        // Create all the creatures
        //------------------------------------------------------------------------------
        addCreature(Creature(
            id: .Orc,
            nameList: ["Orc"],
            health: 10,
            location: .OrcRoom,
            behavior: .Hunter,
            description: "A massive orc stands before you!",
            patrol: [.OrcRoom, .ArchiveLGRoom, .ArchiveNGRoom, .ArchiveCGRoom, .ArchiveCNRoom, .ArchiveCERoom, .ArchiveNERoom, .ArchiveLERoom]
        ))
        
        //------------------------------------------------------------------------------
        // Set up the player
        //------------------------------------------------------------------------------
        player.setLocation(.HospitalRoom)
    }
    
    
    //------------------------------------------------------------------------------
    // addLocation
    // Creates a location and adds it to the world.
    //------------------------------------------------------------------------------
    func addLocation(_ location: Location) {
        assert(locations[location.id] == nil)
        locations[location.id] = location
    }
    
    
    //------------------------------------------------------------------------------
    // addItem
    // Adds an item to the world
    //------------------------------------------------------------------------------
    func addItem(_ item: Item) {
        assert(items[item.id] == nil)
        items[item.id] = item
    }
    
    
    //------------------------------------------------------------------------------
    // addCreature
    // Adds a creature to the world
    //------------------------------------------------------------------------------
    func addCreature(_ creature: Creature) {
        creatures[creature.id] = creature
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
     // creatureFromId
     // Returns the item with a specified id
     //------------------------------------------------------------------------------
     func creatureFromId(_ id: ID) -> Creature {
         return creatures[id]!
     }
    
    
    //------------------------------------------------------------------------------
    // itemFromName
    // Returns the item with a specified human-friendly name
    //------------------------------------------------------------------------------
    func itemFromName(_ name: String) -> Item? {
        return items.values.first(where: { $0.nameList.contains(name) })
    }
    
    typealias CommandTemplate = (String, Any)
    
    let commands: [CommandTemplate] = [
        ("north",                       Player.goNorth),
        ("go north",                    Player.goNorth),
        ("n",                           Player.goNorth),
        ("east",                        Player.goEast),
        ("go east",                     Player.goEast),
        ("e",                           Player.goEast),
        ("west",                        Player.goWest),
        ("go west",                     Player.goWest),
        ("w",                           Player.goWest),
        ("south",                       Player.goSouth),
        ("go south",                    Player.goSouth),
        ("s",                           Player.goSouth),
        ("go down",                     Player.goDown),
        ("d",                           Player.goDown),
        ("down",                        Player.goDown),
        ("go up",                       Player.goUp),
        ("u",                           Player.goUp),
        ("up",                          Player.goUp),
        ("get $item1",                  Player.get),
        ("take $item1",                 Player.get),
        ("use $item1",                  Item.use),
        ("examine $item1",              Item.examineThis),
        ("pick up $item1",              Player.get),
        ("unlock $item2 with $item1",   Item.use),
        ("open $item2 with $item1",     Item.use),
        ("use $item1 on $item2",        Item.use),
        ("drop $item1",                 Player.drop),
        ("god gimme $item1",            Player.gimme),
        ("wait",                        Player.wait),
        ("teleport $location1",         Player.teleport),
        ("inventory",                   Player.getInventory),
        ("i",                           Player.getInventory),
        ("inv",                         Player.getInventory),
        ("save",                        Game.save),
        ("load",                        Game.load),
        ]

    //------------------------------------------------------------------------------
    // takeTurn
    // Handles the basic turn loop and accepts commands.
    //------------------------------------------------------------------------------
    func takeTurn() {
        // Where are we?
        print("\n")
        player.location.describe()
        for item in items.values {
            item.takeTurn()
        }
        for location in locations.values {
            location.takeTurn()
        }
        for creature in creatures.values {
            creature.takeTurn()
        }
        player.takeTurn()
        
        // Get a valid input string.
        // For unknown reasons, this occasionally returns nil, so keep hittin it until
        // we get something sensible.
        var input: String?
        while input == nil {
            input = readLine()
        }
        
        var item1: Item?
        var item2: Item?
        var location1: Location?
        
        // Try every command template in turn and see if it matches the input line
        commandLoop: for (template, callFunc) in commands {
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
        
                // What are we trying to match?
                switch currentPart {
                    
                //In case this doesn't need an item or location argument, match template to input
                case _ where !currentPart.hasPrefix("$"):
                    if workingInput.hasPrefix(currentPart) {
                        workingInput.removeFirst(templateParts[0].count)
                        templateParts.remove(at:0)
                        continue matchLoop
                    } else {
                        continue commandLoop
                    }
                
                //This matches items against the namelist arrays
                case _ where currentPart.hasPrefix("$item"):
                    for item in items.values {
                        for name in item.nameList {
                            
                            //Found a match, remove matching section
                            if workingInput.hasPrefix(name.lowercased()) {
                                if currentPart == "$item1" {
                                    item1 = item
                                } else if currentPart == "Sitem2" {
                                    item2 = item
                                }
                                workingInput.removeFirst(name.count)
                                templateParts.remove(at:0)
                                continue matchLoop
                            }
                        }
                    }
                  
                //In case the next argument is a location, this matches it
                case _ where currentPart.hasPrefix("$location"):
                    for location in locations.values {
                        if workingInput.hasPrefix(location.fullName.lowercased()) {
                            if currentPart == "$location1" {
                                location1 = location
                                workingInput.removeFirst(location.fullName.count)
                                templateParts.remove(at:0)
                                continue matchLoop
                            }
                        }
                    }
                    
                default:
                    assert(false)
                }
            }
            
            
            // One of the strings is empty. Hopefully they both are.
            if !templateParts.isEmpty || !workingInput.isEmpty {
                continue commandLoop
            }
            // We found a match. Execute it
            switch callFunc {
                
            case _ where callFunc is (Game) -> () -> ():
                (callFunc as! (Game) -> () -> ())(game)()
                
            case _ where callFunc is (Player) -> () -> ():
                (callFunc as! (Player) -> () -> ())(player)()
                
            case _ where callFunc is (Player) -> (Item) -> ():
                (callFunc as! (Player) -> (Item) -> ())(player)(item1!)
                
            case _ where callFunc is (Item) -> () -> ():
                (callFunc as! (Item) -> () -> ())(item1!)()
                
            case _ where callFunc is (Item) -> (Item) -> ():
                (callFunc as! (Item) -> (Item) -> ())(item1!)(item2!)
                
            case _ where callFunc is (Player) -> (Location) -> ():
                (callFunc as! (Player) -> (Location) -> ())(player)(location1!)
                
            default:
                assert(false)
            }
            return
        }
        
        // No match
        print("Error: could not find a matching command")
    }
    
    
    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    // Encoding and decoding
    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    
    
    // Our coding keys
    enum CodingKeys: String, CodingKey {
        case player
        case locations
        case items
        case creatures
    }
    

    //------------------------------------------------------------------------------
    // encode
    //------------------------------------------------------------------------------
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(player, forKey: .player)
        try container.encode(locations, forKey: .locations)
        try container.encode(items, forKey: .items)
        try container.encode(creatures, forKey: .creatures)
    }
    

    //------------------------------------------------------------------------------
    // decode
    //------------------------------------------------------------------------------
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        player = try values.decode(Player.self, forKey: .player)
        locations = try values.decode([ID : Location].self, forKey: .locations)
        items = try values.decode([ID : Item].self, forKey: .items)
        creatures = try values.decode([ID : Creature].self, forKey: .creatures)
    }
}
