//
//  main.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/19/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation

var gameEnd = false
let game = Game()
game.buildWorld()
while !gameEnd {
    game.takeTurn()
}
