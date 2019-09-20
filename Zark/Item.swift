//
//  Item.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/19/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa


//Item class
//Names is an array of all the things that you can call the item. For example: Key, Ornate key, Large key, Ornate large key.
//Description is the text you get when you examine an item in a room.
//Examine is the text you get when you examine an item in your inventory.
class Item {
    var names: [String]
    var description: String
    var examine: String
    
    init(names namesIn: [String], description descriptionIn: String, examine examineIn: String) {
        names = namesIn
        description = descriptionIn
        examine = examineIn
    }
}
