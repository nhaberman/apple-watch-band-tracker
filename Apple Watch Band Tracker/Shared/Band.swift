//
//  Band.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import Foundation
import SwiftUI

class Band: Identifiable, Hashable, Decodable, Encodable {
    static func == (lhs: Band, rhs: Band) -> Bool {
        var temp = lhs.bandType == rhs.bandType
            && lhs.color == rhs.color
            && lhs.generation == rhs.generation
            && lhs.edition == rhs.edition
            && lhs.season == rhs.season
            && lhs.year == rhs.year
        
        return temp
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(bandType)
        hasher.combine(color)
        hasher.combine(generation)
        hasher.combine(season)
        hasher.combine(year)
    }
    
    // band properties
    var bandType: BandType { BandType.None }
    var color: String = ""
    
    // optional band properties
    var season: Season? = nil
    var year: Int? = nil
    var generation: Int? = nil
    var edition: String? = nil
    
    // sorting order properties
    var colorOrder: Int? = nil
    var dateOrder: Int? = nil
    var logicalOrder: Int? = nil
    
    // owned band properties
    var size: Int? = nil
    var isOwned: Bool? = nil
    
    init(color: String, season: Season, year: Int, generation: Int? = nil) {
        self.color = color
        self.generation = generation
        self.season = season
        self.year = year
    }
    
    func formattedName() -> String {
        var result: String = self.color
        
        if self.generation != nil && self.edition != nil {
            result += " (G\(self.generation!), \(self.edition!))"
        }
        else if self.generation != nil {
            result += " (G\(self.generation!))"
        }
        else if self.edition != nil {
            result += " (\(self.edition!))"
        }
        
        return result
    }
    
    func formattedDetails() -> String {
        if self.generation != nil && self.edition != nil {
            return "Gen \(self.generation!), \(self.edition!)"
        }
        else if self.generation != nil {
            return "Gen \(self.generation!)"
        }
        else if self.edition != nil {
            return "\(self.edition!)"
        }
        else {
            return ""
        }
    }
}

// Band Subclasses
class SportBand : Band {
    override var bandType: BandType { BandType.SportBand }
    
    private var _pin: String?
    var pin: String { _pin ?? defaultPin}
    let defaultPin: String = "Silver"
    
    init(color: String, season: Season, year: Int, pin: String? = nil, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._pin = pin
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _pin = try values.decodeIfPresent(String.self, forKey: ._pin)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned, bandSize
        case _pin = "pin"
    }
    
    override func formattedName() -> String {
        var result = super.formattedName()
        
        if self.pin != defaultPin {
            let pinDetails = "\(pin) Pin"
            
            if result.last == ")" {
                result.removeLast()
                result += ", \(pinDetails))"
            }
            else {
                result += " (\(pinDetails))"
            }
        }
        
        return result
    }
    
    override func formattedDetails() -> String {
        var result = super.formattedDetails()
        
        if self.pin != defaultPin {
            let pinDetails = "\(pin) Pin"
            
            if result.count == 0 {
                result = pinDetails
            }
            else {
                result += ", \(pinDetails)"
            }
        }
        
        return result
    }
}

class NikeSportBand : Band {
    override var bandType: BandType { BandType.NikeSportBand }
    
    private var _pin: String?
    var pin: String { _pin ?? defaultPin}
    let defaultPin: String = "Silver"
    
    init(color: String, season: Season, year: Int, pin: String = "", generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._pin = pin
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _pin = try values.decodeIfPresent(String.self, forKey: ._pin)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned, bandSize
        case _pin = "pin"
    }
    
    override func formattedName() -> String {
        var result = super.formattedName()
        
        if self.pin != defaultPin {
            let pinDetails = "\(pin) Pin"
            
            if result.last == ")" {
                result.removeLast()
                result += ", \(pinDetails))"
            }
            else {
                result += " (\(pinDetails))"
            }
        }
        
        return result
    }
    
    override func formattedDetails() -> String {
        var result = super.formattedDetails()
        
        if self.pin != defaultPin {
            let pinDetails = "\(pin) Pin"
            
            if result.count == 0 {
                result = pinDetails
            }
            else {
                result += ", \(pinDetails)"
            }
        }
        
        return result
    }
}

class SportLoop : Band {
    override var bandType: BandType { BandType.SportLoop }
    
    private var _bandVersion: SportLoopVersion?
    var bandVersion: SportLoopVersion { _bandVersion ?? .none}
    
    enum SportLoopVersion: String, Decodable {
        case none = "None"
        case shimmer = "Shimmer"
        case fleck = "Fleck"
        case twoTone = "Two-Tone"
        case rails = "Rails"
        case split = "Split"
    }
    
    init(color: String, season: Season, year: Int, bandVersion: SportLoopVersion = .none, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandVersion = bandVersion
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandVersion = try values.decodeIfPresent(SportLoopVersion.self, forKey: ._bandVersion)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned, bandSize
        case _bandVersion = "bandVersion"
    }
}

class NikeSportLoop : Band {
    override var bandType: BandType  { BandType.NikeSportLoop }
    
    private var _bandVersion: NikeSportLoopVersion?
    var bandVersion: NikeSportLoopVersion { _bandVersion ?? .none}
    
    enum NikeSportLoopVersion: String, Decodable {
        case none = "None"
        case original = "Original"
        case reflective = "Reflective"
        case branded = "Branded"
    }
    
    init(color: String, season: Season, year: Int, bandVersion: NikeSportLoopVersion = .none, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandVersion = bandVersion
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandVersion = try values.decodeIfPresent(NikeSportLoopVersion.self, forKey: ._bandVersion)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned, bandSize
        case _bandVersion = "bandVersion"
    }
}

class SoloLoop : Band {
    override var bandType: BandType { BandType.SoloLoop }
    var bandSize: Int?
    
    init(color: String, season: Season, year: Int, bandSize: Int, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandSize = bandSize
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class BraidedSoloLoop : Band {
    override var bandType: BandType { BandType.BraidedSoloLoop }
    var bandSize: Int?
    
    init(color: String, season: Season, year: Int, bandSize: Int, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandSize = bandSize
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class WovenNylon : Band {
    override var bandType: BandType { BandType.WovenNylon }
    
    private var _bandVersion: WovenNylonVersion?
    var bandVersion: WovenNylonVersion { _bandVersion ?? .none}
    
    enum WovenNylonVersion: String, Decodable {
        case none = "None"
        case original = "Original"
        case stripe = "Stripe"
        case check = "Checkered"
        case pinstripe = "Pinstripe"
    }
    
    init(color: String, season: Season, year: Int, bandVersion: WovenNylonVersion = .none, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandVersion = bandVersion
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandVersion = try values.decodeIfPresent(WovenNylonVersion.self, forKey: ._bandVersion)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned, bandSize
        case _bandVersion = "bandVersion"
    }
}

class ClassicBuckle : Band {
    override var bandType: BandType { BandType.ClassicBuckle }
}

class ModernBuckle : Band {
    override var bandType: BandType { BandType.ModernBuckle }
    
    private var _bandSize: BandSize?
    var bandSize: BandSize { _bandSize ?? .none}
    
    enum BandSize: String, Decodable {
        case none = "None"
        case small = "S"
        case medium = "M"
        case large = "L"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize? = nil, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandSize = bandSize
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandSize = "bandSize"
    }
}

class LeatherLoop : Band {
    override var bandType: BandType { BandType.LeatherLoop }
    
    private var _bandSize: BandSize?
    var bandSize: BandSize { _bandSize ?? .none}
    
    enum BandSize: String, Decodable {
        case none = "None"
        case medium = "M"
        case large = "L"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize? = nil, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandSize = bandSize
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandSize = "bandSize"
    }
}

class LeatherLink : Band {
    override var bandType: BandType { BandType.LeatherLink }
    
    private var _bandSize: BandSize?
    var bandSize: BandSize { _bandSize ?? .none}
    
    enum BandSize: String, Decodable {
        case none = "None"
        case smallMedium = "S/M"
        case mediumLarge = "M/L"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize? = nil, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandSize = bandSize
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandSize = "bandSize"
    }
}

class MilaneseLoop : Band {
    override var bandType: BandType { BandType.MilaneseLoop }
}

class LinkBracelet : Band {
    override var bandType: BandType { BandType.LinkBracelet }
}

class ThirdPartyBand : Band {
    override var bandType: BandType { BandType.ThirdPartyBand }
    var manufacturer: String?
    
    init(color: String, season: Season = .spring, year: Int = 0, manufacturer: String? = nil, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.manufacturer = manufacturer
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        manufacturer = try values.decodeIfPresent(String.self, forKey: .manufacturer)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned, bandSize, manufacturer
    }
    
    override func formattedName() -> String {
        var result = super.formattedName()
        
        if manufacturer != nil {
            result = manufacturer! + " " + result
        }
        
        return result
    }
}
