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
class Item {
    var id: ItemID
    var nameList: [String]
    var roomDescription: String
    var examine: String
   
    
    //------------------------------------------------------------------------------
    // Initializer
    //------------------------------------------------------------------------------
    init(id idIn: ItemID, nameList nameListIn: [String], roomDescription roomDescriptionIn: String, examine examineIn: String) {
        id = idIn
        nameList = nameListIn
        roomDescription = roomDescriptionIn
        examine = examineIn
    }
}


//------------------------------------------------------------------------------
// ItemID enum
//------------------------------------------------------------------------------
enum ItemID {
    case Geode
    case Key
}
