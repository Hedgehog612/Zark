//
//  Key.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/22/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


class Key: Item {
    override func use(item: Item) {
        if game.world.player.location.containsItem(.Door) {
            if game.world.itemFromId(.Door).properties[.Unlocked] == 1 {
                print("The door is already unlocked.")
            } else {
                game.world.locationFromId(.BriefingRoom).connect(direction: .North, destination: .ViewingRoom)
                print("You insert the key into the lock and turn. The door swings open.")
                game.world.itemFromId(.Door).roomDescription = "The northern door stands open."
                game.world.itemFromId(.Door).properties[.Unlocked] = 1
            }
        } else if game.world.player.location.containsItem(.Geode) {
            if game.world.itemFromId(.Geode).properties[.Unlocked] == 1 {
                print("The geode is already unlocked.")
            } else {
                game.world.locationFromId(.GeodeRoom).contents = [.Crystal]
                print("You insert the key into the rock and turn. The rock splits into two pieces. Inside, you see shining purple crystals lining the walls of the geode.")
                game.world.itemFromId(.Geode).properties[.Unlocked] = 1
            }
        } else {
            print("There isn't anything to use the key on here.")
        }
    }
}
