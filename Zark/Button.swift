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
    override func use(item: Item) {
        if game.world.player.location.containsItem(.Button) {
            print("You press the button. Nothing seems to happen.")
            if game.world.itemFromId(.Lamp).properties[.Light] == 0 {
                game.world.itemFromId(.Lamp).properties[.Light] = 1
                game.world.locationFromId(.DarkRoom).connect(direction: .West, destination: .ArchiveCERoom)
                game.world.locationFromId(.DarkRoom).roomDescription = "You stand in a cramped corridor that runs east to west."
                game.world.itemFromId(.Lamp).roomDescription = "A brightly shining lamp rests on the ground."
                return
            } else {
                game.world.itemFromId(.Lamp).properties[.Light] = 0
                game.world.locationFromId(.DarkRoom).connections = [.East : .ViewingRoom]
                game.world.locationFromId(.DarkRoom).roomDescription = "You stand in a cramped corridor that runs east to west."
                game.world.itemFromId(.Lamp).roomDescription = "An unlit lamp rests on the ground."
            }
        }
    }
    
}
