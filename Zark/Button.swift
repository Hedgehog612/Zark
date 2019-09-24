//
//  Button.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/23/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa

class Button: Item {
    //------------------------------------------------------------------------------
    // useButton
    //------------------------------------------------------------------------------
    override func use(item: Item?) {
        if game.player.location.containsItem(.Button) {
            print("You press the button. Nothing seems to happen.")
            if game.itemFromId(.Lamp).properties[.Light] == 0 {
                game.itemFromId(.Lamp).properties[.Light] = 1
                game.locationFromId(.DarkRoom).connect(direction: .West, destination: .ArchiveRoom)
                game.locationFromId(.DarkRoom).roomDescription = "You stand in a cramped corridor that runs east to west."
                game.itemFromId(.Lamp).roomDescription = "A brightly shining lamp rests on the ground."
                return
            } else {
                game.itemFromId(.Lamp).properties[.Light] = 0
                game.locationFromId(.DarkRoom).connections = [.East : .ViewingRoom]
                game.locationFromId(.DarkRoom).roomDescription = "You stand in a cramped corridor that runs east to west."
                game.itemFromId(.Lamp).roomDescription = "An unlit lamp rests on the ground."
            }
        }
    }
    
}
