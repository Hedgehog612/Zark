//
//  Game.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/19/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa


//------------------------------------------------------------------------------
// Game
//------------------------------------------------------------------------------
class Game: Codable {
    var world: World
    
    
    //------------------------------------------------------------------------------
    // Initializer
    //------------------------------------------------------------------------------
    init() {
        //World
        world = World()
    }
    
    
    //------------------------------------------------------------------------------
    // getDocumentsDirectory
    //------------------------------------------------------------------------------
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    
    //------------------------------------------------------------------------------
    // save
    // Saves the game
    //------------------------------------------------------------------------------
    func save() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(world)
            let string = String(data: data, encoding: .utf8)!
            print(string)
            let filename = getDocumentsDirectory().appendingPathComponent("output.txt")

            do {
                try string.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("Could not write to file.")
            }
        }
        catch {
            print("Saving error")
        }
    }
    
    
    //------------------------------------------------------------------------------
    // load
    // Loads the game
    //------------------------------------------------------------------------------
    func load() {
        do {
            let jsonString = try String(contentsOfFile: "/Users/Marcus/Documents/output.txt")
            let decoder = JSONDecoder()
            do {
                world = try decoder.decode(World.self, from: jsonString.data(using: .utf8)!)
            } catch {
                print("Loading error")
            }
        } catch {
            //Could not find file to load
            print("Could not find file to load")
        }
    }
}
