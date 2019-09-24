//
//  CommandTemplate.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/24/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa

typealias CommandTemplate = (String, (Player) -> (Item?) -> (), (Item) -> (Item?) -> ())
commands: CommandTemplate[] = [
    ("north",                       goNorth,            nil),
    ("east",                        goEast,             nil),
    ("south",                       goSouth,            nil),
    ("west",                        go West,            nil),
    ("get $item1",                  getItem,            nil),
    ("use $item1",                  use,                nil),
    ("examine $item1",              examine,            nil),
    ("pick up $item1",              getItem,            nil),
    ("unlock $item2 with $item1",   nil,                unlock),
    ("open $item2 with $item1",     nil,                unlock)
]

input = 
for (template, playerCommand, itemCommand) in CommandTemplate {
template is the working copy of the template string
input is the working copy of the input string
var item1: String?
var item2: String?

while template != nil

    templatePart = first part of template
    if input doesn't begin with templatePart
        bail out

    cut template part off template
    cut matching part off input

if input != nil
    No match, bail out
    
Match, execute command

match input

if templatePart doesn't begin with $
    if input begins with templatePart
else
    for all items
        for all names of the item
            does input begin with that name?
                If yes, set .item1 or .item2 and return true

return false

