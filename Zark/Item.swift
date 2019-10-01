//
//  Item.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/19/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa


//------------------------------------------------------------------------------
// Item
// Names is an array of all the things that you can call the item. For example:
//      Key, Ornate key, Large key, Ornate large key.
// Description is the text you get when you examine an item in a room.
// Examine is the text you get when you examine an item in your inventory.
//------------------------------------------------------------------------------
class Item: Entity {
    var nameList: [String]
    var roomDescription: String
    var dropDescription: String
    var examine: String
    var pickedUp: Bool
    var canPickUp: Bool
   
    
    //------------------------------------------------------------------------------
    // Initializer
    //------------------------------------------------------------------------------
    init(id idIn: ID, nameList nameListIn: [String], roomDescription roomDescriptionIn: String, dropDescription dropDescriptionIn: String, examine examineIn: String, canPickUp canPickUpIn: Bool = true, properties propertiesIn: [PropertyId : Int] = [:]) {
        nameList = nameListIn
        roomDescription = roomDescriptionIn
        dropDescription = dropDescriptionIn
        examine = examineIn
        pickedUp = false
        canPickUp = canPickUpIn
        
        super.init(id: idIn, properties: propertiesIn)
    }

    
    //------------------------------------------------------------------------------
    // Describe
    //------------------------------------------------------------------------------
    func describe() {
        if pickedUp == false {
            print(roomDescription)
        } else {
            print(dropDescription)
        }
    }
    
    
    //------------------------------------------------------------------------------
    // use
    //------------------------------------------------------------------------------
    func use(item: Item) {
        print("You can't do anything special with the \(nameList[0]).")
    }
    
    
    //------------------------------------------------------------------------------
    // takeTurn
    //------------------------------------------------------------------------------
    func takeTurn() {
        return
    }
    
    
    //------------------------------------------------------------------------------
    // examine
    // Gives more detailed information about an item in your inventory.
    //------------------------------------------------------------------------------
    func examineThis() {
        print(examine)
    }
    
    
    //------------------------------------------------------------------------------
    // onDrop
    //------------------------------------------------------------------------------
    func onDrop() -> Bool {
        if properties[.Cursed] == 1 {
            print("You are compelled to hold on to the \(nameList[0]).")
            return false
        }
        return true
    }
    
    //------------------------------------------------------------------------------
    // onGet
    //------------------------------------------------------------------------------
    func onGet() -> Bool {
        if properties[.Hot] == 1 {
            print("The \(nameList[0]) is too hot to hold!")
            return false
        }
        return true
    }
    
    
    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    // Encoding and decoding
    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    
    
    // Our coding keys
    enum CodingKeys: String, CodingKey {
        case id
        case properties
        case nameList
        case roomDescription
        case dropDescription
        case examine
        case pickedUp
        case canPickUp
    }
    

    //------------------------------------------------------------------------------
    // encode
    //------------------------------------------------------------------------------
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(properties, forKey: .properties)
        try container.encode(nameList, forKey: .nameList)
        try container.encode(roomDescription, forKey: .roomDescription)
        try container.encode(dropDescription, forKey: .dropDescription)
        try container.encode(examine, forKey: .examine)
        try container.encode(pickedUp, forKey: .pickedUp)
        try container.encode(canPickUp, forKey: .canPickUp)
    }
    

    //------------------------------------------------------------------------------
    // decode
    //------------------------------------------------------------------------------
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let idTemp = try values.decode(ID.self, forKey: .id)
        let propertiesTemp = try values.decode([PropertyId: Int].self, forKey: .properties)
        
        nameList = try values.decode([String].self, forKey: .nameList)
        roomDescription = try values.decode(String.self, forKey: .roomDescription)
        dropDescription = try values.decode(String.self, forKey: .dropDescription)
        examine = try values.decode(String.self, forKey: .examine)
        pickedUp = try values.decode(Bool.self, forKey: .pickedUp)
        canPickUp = try values.decode(Bool.self, forKey: .canPickUp)

        super.init(id: idTemp, properties: propertiesTemp)
    }
    
}


//------------------------------------------------------------------------------
// propertyId enum
//------------------------------------------------------------------------------
enum PropertyId: String, Codable {
    case Unlocked
    case StandingWithTrappers
    case FuseIsLit
    case Light
    case Fuel
    case Dark
    case Hunt
    case Hot
    case Cursed
}
