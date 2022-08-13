//
//  Band.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import Foundation
import SwiftUI

class Band: Identifiable, Hashable, Decodable {
    static func == (lhs: Band, rhs: Band) -> Bool {
        return lhs.bandType == rhs.bandType
            && lhs.color == rhs.color
            && lhs.generation == rhs.generation
            && lhs.season == rhs.season
            && lhs.year == rhs.year
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(bandType)
        hasher.combine(color)
        hasher.combine(generation)
        hasher.combine(season)
        hasher.combine(year)
    }
        
    var bandType: BandType { get { return BandType.None }}
    var color: String = "None"
    var generation: Int = 0
    var season: Season = Season.spring
    var year: Int = 0
    var edition: String = ""
    var size: Int = 0
    var colorOrder = 0
    var dateOrder = 0
    var logicalOrder = 0
    var isOwned = true
    
    init(color: String, season: Season, year: Int, generation: Int = 0) {
        self.color = color
        self.generation = generation
        self.season = season
        self.year = year
    }
    
    func formattedColorName() -> String {
        if (self.generation != 0) {
            return "\(self.color) (Gen \(self.generation))"
        }
        else {
            return self.color
        }
    }
}

// Band Subclasses
class SportBand : Band {
    override var bandType: BandType { get { return BandType.SportBand }}
    var pin: String = "Silver"
    
    init(color: String, season: Season, year: Int, pin: String = "", generation: Int = 0) {
        super.init(color: color, season: season, year: year, generation: generation)
        
        if(!pin.isEmpty) {
            self.pin = pin
        }
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class NikeSportBand : Band {
    override var bandType: BandType { get { return BandType.NikeSportBand }}
    var pin: String = "Silver"
    
    init(color: String, season: Season, year: Int, pin: String = "", generation: Int = 0) {
        super.init(color: color, season: season, year: year, generation: generation)
        
        if(!pin.isEmpty) {
            self.pin = pin
        }
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class SportLoop : Band {
    override var bandType: BandType { get { return BandType.SportLoop }}
    var bandVersion : SportLoopVersion = .none
    
    enum SportLoopVersion : String, Decodable {
        case none = "None"
        case shimmer = "Shimmer"
        case fleck = "Fleck"
        case twoTone = "Two-Tone"
        case rails = "Rails"
        case split = "Split"
    }
    
    init(color: String, season: Season, year: Int, bandVersion: SportLoopVersion = .none, generation: Int = 0) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandVersion = bandVersion
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class NikeSportLoop : Band {
    override var bandType: BandType { get { return BandType.NikeSportLoop }}
    var bandVersion : NikeSportLoopVersion = .none
    
    enum NikeSportLoopVersion : String, Decodable {
        case none = "None"
        case original = "Original"
        case reflective = "Reflective"
        case branded = "Branded"
    }
    
    init(color: String, season: Season, year: Int, bandVersion: NikeSportLoopVersion = .none, generation: Int = 0) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandVersion = bandVersion
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class SoloLoop : Band {
    override var bandType: BandType { get { return BandType.SoloLoop }}
    var bandSize : Int = 0
    
    init(color: String, season: Season, year: Int, bandSize: Int, generation: Int = 0) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandSize = bandSize
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class BraidedSoloLoop : Band {
    override var bandType: BandType { get { return BandType.BraidedSoloLoop }}
    var bandSize : Int = 0
    
    init(color: String, season: Season, year: Int, bandSize: Int, generation: Int = 0) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandSize = bandSize
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class WovenNylon : Band {
    override var bandType: BandType { get { return BandType.WovenNylon }}
    var bandVersion : WovenNylonVersion = .none
    
    enum WovenNylonVersion : String, Decodable {
        case none = "None"
        case original = "Original"
        case stripe = "Stripe"
        case check = "Checkered"
        case pinstripe = "Pinstripe"
    }
    
    init(color: String, season: Season, year: Int, bandVersion: WovenNylonVersion = .none, generation: Int = 0) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandVersion = bandVersion
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class ClassicBuckle : Band {
    override var bandType: BandType { get { return BandType.ClassicBuckle }}
}

class ModernBuckle : Band {
    override var bandType: BandType { get { return BandType.ModernBuckle }}
    var bandSize : BandSize = .small
    
    enum BandSize : String, Decodable {
        case small = "S"
        case medium = "M"
        case large = "L"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize, generation: Int = 0) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandSize = bandSize
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class LeatherLoop : Band {
    override var bandType: BandType { get { return BandType.LeatherLoop }}
    var bandSize : BandSize = .medium
    
    enum BandSize : String, Decodable {
        case medium = "M"
        case large = "L"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize, generation: Int = 0) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandSize = bandSize
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class LeatherLink : Band {
    override var bandType: BandType { get { return BandType.LeatherLink }}
    var bandSize : BandSize = .smallMedium
    
    enum BandSize : String, Decodable {
        case smallMedium = "S/M"
        case mediumLarge = "M/L"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize, generation: Int = 0) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandSize = bandSize
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class MilaneseLoop : Band {
    override var bandType: BandType { get { return BandType.MilaneseLoop }}
    
}

class LinkBracelet : Band {
    override var bandType: BandType { get { return BandType.LinkBracelet }}
    
}

class ThirdPartyBand : Band {
    override var bandType: BandType { get { return BandType.ThirdPartyBand }}
    var manufacturer : String = ""
    
    init(color: String, season: Season, year: Int, manufacturer: String = "", generation: Int = 0) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.manufacturer = manufacturer
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

