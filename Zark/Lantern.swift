//
//  Lantern.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/23/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa

class Lantern: Item {
    func use() {
        if Player.itemInInventory(.Lantern) == true {
                if properties[.On] == 0 {
                    print("You turn on the lantern.")
                    properties[.On] = 1
                } else {
                    print("You turn off the lantern.")
                    properties[.On] = 0
                }
            }
        }
        
        override func takeTurn() {
            if properties[.Fuel]! > 0 && properties[.On] == 1 {
                print("The lantern flickers brightly.")
                properties[.Fuel]! -= 1
            }
            if properties[.Fuel] == 0 && properties[.On] == 1 {
                print("The lantern goes out!")
                properties[.On] = 0
            }
        }
    }
