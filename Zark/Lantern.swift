//
//  Lantern.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/23/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa

class Lantern: Item {
    override func use(item: Item) {
        if game.world.player.itemInInventory(.Lantern) == true {
                if properties[.Light] == 0 {
                    print("You turn on the lantern.")
                    properties[.Light] = 1
                } else {
                    print("You turn off the lantern.")
                    properties[.Light] = 0
                }
            }
        }
        
        override func takeTurn() {
            if properties[.Fuel]! > 0 && properties[.Light] == 1 {
                print("The lantern flickers brightly.")
                properties[.Fuel]! -= 1
            }
            if properties[.Fuel] == 0 && properties[.Light] == 1 {
                print("The lantern goes out!")
                properties[.Light] = 0
            }
        }
    
    
    override func examineThis() {
        if properties[.Fuel]! > 7 {
            print("There's still plenty of fuel in the lantern.")
        } else {
            if properties[.Fuel]! > 3 {
                print("The lantern's about half-empty.")
            } else {
                print("The lantern's almost out of fuel!")
            }
        }
    }
}
