//
//  Band.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import Foundation
import SwiftUI

class Band: Identifiable, Hashable, Codable {
    static func == (lhs: Band, rhs: Band) -> Bool {
        return lhs.bandType == rhs.bandType
            && lhs.color == rhs.color
            && lhs.generation == rhs.generation
            && lhs.edition == rhs.edition
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
    
    // band properties
    var bandType: BandType
    var color: String
    
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
        self.bandType = .None
        self.color = color
        self.generation = generation
        self.season = season
        self.year = year
    }
    
    // coding keys for specific band properties
//    enum CodingKeys: String, CodingKey {
//        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
//    }
    
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
    private var _pin: String?
    var pin: String { _pin ?? defaultPin}
    let defaultPin: String = "Silver"
    
    init(color: String, season: Season, year: Int, pin: String? = nil, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._pin = pin
        self.bandType = .SportBand
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _pin = try values.decodeIfPresent(String.self, forKey: ._pin)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
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
    private var _pin: String?
    var pin: String { _pin ?? defaultPin}
    let defaultPin: String = "Silver"
    
    init(color: String, season: Season, year: Int, pin: String = "", generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._pin = pin
        self.bandType = .NikeSportBand
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _pin = try values.decodeIfPresent(String.self, forKey: ._pin)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
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
    private var _bandVersion: SportLoopVersion?
    var bandVersion: SportLoopVersion { _bandVersion ?? .none}
    
    enum SportLoopVersion: String, Codable {
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
        self.bandType = .SportLoop
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandVersion = try values.decodeIfPresent(SportLoopVersion.self, forKey: ._bandVersion)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandVersion = "bandVersion"
    }
}

class NikeSportLoop : Band {
    private var _bandVersion: NikeSportLoopVersion?
    var bandVersion: NikeSportLoopVersion { _bandVersion ?? .none}
    
    enum NikeSportLoopVersion: String, Codable {
        case none = "None"
        case original = "Original"
        case reflective = "Reflective"
        case branded = "Branded"
    }
    
    init(color: String, season: Season, year: Int, bandVersion: NikeSportLoopVersion = .none, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandVersion = bandVersion
        self.bandType = .NikeSportLoop
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandVersion = try values.decodeIfPresent(NikeSportLoopVersion.self, forKey: ._bandVersion)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandVersion = "bandVersion"
    }
}

class SoloLoop : Band {
    var bandSize: Int?
    
    init(color: String, season: Season, year: Int, bandSize: Int, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandSize = bandSize
        self.bandType = .SoloLoop
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bandSize = try values.decodeIfPresent(Int.self, forKey: .bandSize)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned, bandSize
    }
}

class BraidedSoloLoop : Band {
    var bandSize: Int?
    
    init(color: String, season: Season, year: Int, bandSize: Int, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandSize = bandSize
        self.bandType = .BraidedSoloLoop
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bandSize = try values.decodeIfPresent(Int.self, forKey: .bandSize)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned, bandSize
    }
}

class WovenNylon : Band {
    private var _bandVersion: WovenNylonVersion?
    var bandVersion: WovenNylonVersion { _bandVersion ?? .none}
    
    enum WovenNylonVersion: String, Codable {
        case none = "None"
        case original = "Original"
        case stripe = "Stripe"
        case check = "Checkered"
        case pinstripe = "Pinstripe"
    }
    
    init(color: String, season: Season, year: Int, bandVersion: WovenNylonVersion = .none, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandVersion = bandVersion
        self.bandType = .WovenNylon
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandVersion = try values.decodeIfPresent(WovenNylonVersion.self, forKey: ._bandVersion)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandVersion = "bandVersion"
    }
}

class ClassicBuckle : Band {
    override init(color: String, season: Season = .spring, year: Int = 0, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandType = .ClassicBuckle
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class ModernBuckle : Band {
    private var _bandSize: BandSize?
    var bandSize: BandSize { _bandSize ?? .none}
    
    enum BandSize: String, Codable {
        case none = "None"
        case small = "S"
        case medium = "M"
        case large = "L"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize? = nil, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandSize = bandSize
        self.bandType = .ModernBuckle
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandSize = try values.decodeIfPresent(BandSize.self, forKey: ._bandSize)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandSize = "bandSize"
    }
}

class LeatherLoop : Band {
    private var _bandSize: BandSize?
    var bandSize: BandSize { _bandSize ?? .none}
    
    enum BandSize: String, Codable {
        case none = "None"
        case medium = "M"
        case large = "L"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize? = nil, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandSize = bandSize
        self.bandType = .LeatherLoop
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandSize = try values.decodeIfPresent(BandSize.self, forKey: ._bandSize)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandSize = "bandSize"
    }
}

class LeatherLink : Band {
    private var _bandSize: BandSize?
    var bandSize: BandSize { _bandSize ?? .none}
    
    enum BandSize: String, Codable {
        case none = "None"
        case smallMedium = "S/M"
        case mediumLarge = "M/L"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize? = nil, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandSize = bandSize
        self.bandType = .LeatherLink
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandSize = try values.decodeIfPresent(BandSize.self, forKey: ._bandSize)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandSize = "bandSize"
    }
}

class MilaneseLoop : Band {
    override init(color: String, season: Season = .spring, year: Int = 0, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandType = .MilaneseLoop
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class LinkBracelet : Band {
    override init(color: String, season: Season = .spring, year: Int = 0, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.bandType = .LinkBracelet
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

class ThirdPartyBand : Band {
    var manufacturer: String?
    
    init(color: String, season: Season = .spring, year: Int = 0, manufacturer: String? = nil, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.manufacturer = manufacturer
        self.bandType = .ThirdPartyBand
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        manufacturer = try values.decodeIfPresent(String.self, forKey: .manufacturer)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned, manufacturer
    }
    
    override func formattedName() -> String {
        var result = super.formattedName()
        
        if manufacturer != nil {
            result = manufacturer! + " " + result
        }
        
        return result
    }
}
