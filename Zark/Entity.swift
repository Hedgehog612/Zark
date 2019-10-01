//
//  Entity.swift
//  Zark
//
//  Created by Marcus Bamberger on 9/22/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation

class Entity: Codable {
    var id: ID
    var properties: [PropertyId: Int]
    
    
    //initializer
    init(id idIn: ID, properties propertiesIn: [PropertyId: Int]) {
        id = idIn
        properties = propertiesIn
    }
    
    
    
}


//------------------------------------------------------------------------------
// ID enum
//------------------------------------------------------------------------------
enum ID: String, Codable {
    
    //These are the locations
    case LockerRoom
    case BriefingRoom
    case MapRoom
    case GeodeRoom
    case ViewingRoom
    case DarkRoom
    case ArchiveRoom
    case MoonRoom
    case HospitalRoom
    case SupplyRoom
    case ScuffleRoom
    case LogRoom
    case DarkEntranceRoom
    case BoilerRoom
    case ObservationDeckRoom
    case PlatformRoom
    case SplitRoom
    case MonitoringStationRoom
    case CatwalkOutRoom
    case EngineRoom
    case OfficeRoom
    case EngineOfficeRoom
    case EngineNorthRoom
    case SealedExitRoom
    case ArchiveCERoom
    case ArchiveNERoom
    case ArchiveLERoom
    case ArchiveCNRoom
    case ArchiveNNRoom
    case OrcRoom
    case ArchiveCGRoom
    case ArchiveNGRoom
    case ArchiveLGRoom
    case GeneratorRoom
    case TunnelOneRoom
    case TunnelTwoRoom
    
    //These are the items
    case Lamp
    case Geode
    case Key
    case Lantern
    case Button
    case Door
    case Crystal
    case Map
    case Keycard
    
    //These are the creatures
    case Orc
}
