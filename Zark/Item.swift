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
    func use(item: Item?) {
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
    func examine(item: Item?) {
        assert(item == nil)
        print(examine)
    }
}


//------------------------------------------------------------------------------
// propertyId enum
//------------------------------------------------------------------------------
enum PropertyId {
    case Unlocked
    case StandingWithTrappers
    case FuseIsLit
    case Light
    case Fuel
    case On
}
