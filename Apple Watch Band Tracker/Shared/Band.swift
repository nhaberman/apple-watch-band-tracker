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
        if lhs.bandType != rhs.bandType {
            return false
        }
        else {
            let baseEquality = lhs.color == rhs.color
                && lhs.generation == rhs.generation
                && lhs.edition == rhs.edition
                && lhs.season == rhs.season
                && lhs.year == rhs.year
            
            switch lhs.bandType {
            case .SportBand:
                return baseEquality && (lhs as! SportBand).pin == (rhs as! SportBand).pin
            case .NikeSportBand:
                return baseEquality && (lhs as! NikeSportBand).pin == (rhs as! NikeSportBand).pin
            case .SportLoop:
                return baseEquality && (lhs as! SportLoop).bandVersion == (rhs as! SportLoop).bandVersion
            case .NikeSportLoop:
                return baseEquality && (lhs as! NikeSportLoop).bandVersion == (rhs as! NikeSportLoop).bandVersion
            case .SoloLoop:
                return baseEquality && (lhs as! SoloLoop).bandSize == (rhs as! SoloLoop).bandSize
            case .BraidedSoloLoop:
                return baseEquality && (lhs as! BraidedSoloLoop).bandSize == (rhs as! BraidedSoloLoop).bandSize
            case .WovenNylon:
                return baseEquality && (lhs as! WovenNylon).bandVersion == (rhs as! WovenNylon).bandVersion
            case .ClassicBuckle:
                return baseEquality
            case .ModernBuckle:
                return baseEquality && (lhs as! ModernBuckle).bandSize == (rhs as! ModernBuckle).bandSize
            case .LeatherLoop:
                return baseEquality && (lhs as! LeatherLoop).bandSize == (rhs as! LeatherLoop).bandSize
            case .LeatherLink:
                return baseEquality && (lhs as! LeatherLink).bandSize == (rhs as! LeatherLink).bandSize
            case .MagneticLink:
                return baseEquality && (lhs as! MagneticLink).bandSize == (rhs as! MagneticLink).bandSize
            case .MilaneseLoop:
                return baseEquality
            case .LinkBracelet:
                return baseEquality
            case .AlpineLoop:
                return baseEquality && (lhs as! AlpineLoop).bandSize == (rhs as! AlpineLoop).bandSize
            case .TrailLoop:
                return baseEquality && (lhs as! TrailLoop).bandSize == (rhs as! TrailLoop).bandSize
            case .OceanBand:
                return baseEquality
            case .ThirdPartyBand:
                return baseEquality && (lhs as! ThirdPartyBand).manufacturer == (rhs as! ThirdPartyBand).manufacturer
            default:
                return baseEquality
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(bandType)
        hasher.combine(color)
        hasher.combine(generation)
        hasher.combine(season)
        hasher.combine(year)
    }
    
    // required band properties
    var bandID: UUID
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
    var watchSize: Int? = nil
    var isOwned: Bool = false
    var isFavorite: Bool = false
    
    init(color: String, season: Season, year: Int, generation: Int? = nil) {
        self.bandID = UUID()
        self.bandType = .None
        self.color = color
        self.generation = generation
        self.season = season
        self.year = year
        self.isOwned = true
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.bandID, forKey: .bandID)
        try container.encodeIfPresent(self.bandType, forKey: .bandType)
        try container.encodeIfPresent(self.color, forKey: .color)
        try container.encodeIfPresent(self.season, forKey: .season)
        try container.encodeIfPresent(self.year, forKey: .year)
        try container.encodeIfPresent(self.generation, forKey: .generation)
        try container.encodeIfPresent(self.edition, forKey: .edition)
        try container.encodeIfPresent(self.colorOrder, forKey: .colorOrder)
        try container.encodeIfPresent(self.dateOrder, forKey: .dateOrder)
        try container.encodeIfPresent(self.logicalOrder, forKey: .logicalOrder)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bandID = try container.decode(UUID.self, forKey: .bandID)
        bandType = try container.decode(BandType.self, forKey: .bandType)
        color = try container.decode(String.self, forKey: .color)
        season = try container.decodeIfPresent(Season.self, forKey: .season)
        year = try container.decodeIfPresent(Int.self, forKey: .year)
        generation = try container.decodeIfPresent(Int.self, forKey: .generation)
        edition = try container.decodeIfPresent(String.self, forKey: .edition)
        colorOrder = try container.decodeIfPresent(Int.self, forKey: .colorOrder)
        dateOrder = try container.decodeIfPresent(Int.self, forKey: .dateOrder)
        logicalOrder = try container.decodeIfPresent(Int.self, forKey: .logicalOrder)
        watchSize = try container.decodeIfPresent(Int.self, forKey: .watchSize)
        isOwned = try container.decodeIfPresent(Bool.self, forKey: .isOwned) ?? false
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
    }
    
    // coding keys for band properties
    enum CodingKeys: String, CodingKey {
        case bandID, bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, watchSize, isOwned, isFavorite
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
    var pin: String?
    
    init(color: String, season: Season, year: Int, pin: String? = nil, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.pin = pin
        self.bandType = .SportBand
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pin = try values.decodeIfPresent(String.self, forKey: .pin)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.pin, forKey: .pin)
        try super.encode(to: encoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned, pin
    }
    
    override func formattedName() -> String {
        var result = super.formattedName()
        
        if self.pin != nil {
            let pinDetails = "\(pin!) Pin"
            
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
        
        if self.pin != nil {
            let pinDetails = "\(pin!) Pin"
            
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
    var pin: String?
    
    private var _bandVersion: NikeSportBandVersion?
    var bandVersion: NikeSportBandVersion { _bandVersion ?? .none }
    
    enum NikeSportBandVersion: String, Codable {
        case none = "None"
        case classic = "Classic"
        case colorFlakes = "Color Flakes"
    }
    
    init(color: String, season: Season, year: Int, pin: String = "", bandVersion: NikeSportBandVersion = .none, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self.pin = pin
        self._bandVersion = bandVersion
        self.bandType = .NikeSportBand
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pin = try values.decodeIfPresent(String.self, forKey: .pin)
        _bandVersion = try values.decodeIfPresent(NikeSportBandVersion.self, forKey: ._bandVersion)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.pin, forKey: .pin)
        try super.encode(to: encoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned, pin
        case _bandVersion = "bandVersion"
    }
    
    override func formattedName() -> String {
        var result = super.formattedName()
        
        if self.pin != nil {
            let pinDetails = "\(pin!) Pin"
            
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
        
        if self.pin != nil {
            let pinDetails = "\(pin!) Pin"
            
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
    var bandVersion: SportLoopVersion { _bandVersion ?? .none }
    
    enum SportLoopVersion: String, Codable {
        case none = "None"
        case shimmer = "Shimmer"
        case fleck = "Fleck"
        case twoTone = "Two-Tone"
        case rails = "Rails"
        case split = "Split"
        case stripes = "Stripes"
        case connectors = "Connectors"
        case singleTone = "Single-Tone"
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
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.bandVersion, forKey: ._bandVersion)
        try super.encode(to: encoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandVersion = "bandVersion"
    }
}

class NikeSportLoop : Band {
    private var _bandVersion: NikeSportLoopVersion?
    var bandVersion: NikeSportLoopVersion { _bandVersion ?? .none }
    
    enum NikeSportLoopVersion: String, Codable {
        case none = "None"
        case original = "Original"
        case reflective = "Reflective"
        case branded = "Branded"
        case logo = "Logo"
        case pullTab = "Pull Tab"
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
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.bandVersion, forKey: ._bandVersion)
        try super.encode(to: encoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandVersion = "bandVersion"
    }
    
    override func formattedName() -> String {
        var result = super.formattedName()
        
        if self.bandVersion == .branded || self.bandVersion == .logo {
            if result.last == ")" {
                result.removeLast()
                result += ", \(bandVersion.rawValue))"
            }
            else {
                result += " (\(bandVersion.rawValue))"
            }
        }
        
        return result
    }
    
    override func formattedDetails() -> String {
        var result = super.formattedDetails()
        
        if self.bandVersion == .branded || self.bandVersion == .logo {
            if result.count == 0 {
                result = bandVersion.rawValue
            }
            else {
                result += ", \(bandVersion.rawValue)"
            }
        }
        
        return result
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
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.bandSize, forKey: .bandSize)
        try super.encode(to: encoder)
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
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.bandSize, forKey: .bandSize)
        try super.encode(to: encoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned, bandSize
    }
}

class WovenNylon : Band {
    private var _bandVersion: WovenNylonVersion?
    var bandVersion: WovenNylonVersion { _bandVersion ?? .none }
    
    enum WovenNylonVersion: String, Codable {
        case none = "None"
        case original = "Original"
        case stripe = "Stripe"
        case check = "Checked"
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
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.bandVersion, forKey: ._bandVersion)
        try super.encode(to: encoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandVersion = "bandVersion"
    }
    
    override func formattedName() -> String {
        var result = super.formattedName()
        
        if self.bandVersion != .none && self.bandVersion != .original {
            if result.last == ")" {
                result.removeLast()
                result += ", \(bandVersion.rawValue))"
            }
            else {
                result += " (\(bandVersion.rawValue))"
            }
        }
        
        return result
    }
    
    override func formattedDetails() -> String {
        var result = super.formattedDetails()
        
        if self.bandVersion != .none && self.bandVersion != .original {
            if result.count == 0 {
                result = bandVersion.rawValue
            }
            else {
                result += ", \(bandVersion.rawValue)"
            }
        }
        
        return result
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
    var bandSize: BandSize { _bandSize ?? .none }
    
    enum BandSize: String, Codable {
        case none = "None"
        case small = "S"
        case medium = "M"
        case large = "L"
    }
    
    private var _bandVersion: ModernBuckleVersion?
    var bandVersion: ModernBuckleVersion { _bandVersion ?? .none}
    
    enum ModernBuckleVersion: String, Codable {
        case none = "None"
        case leather = "Leather"
        case fineWoven = "FineWoven"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize? = nil, bandVersion: ModernBuckleVersion = .none, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandSize = bandSize
        self._bandVersion = bandVersion
        self.bandType = .ModernBuckle
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandSize = try values.decodeIfPresent(BandSize.self, forKey: ._bandSize)
        _bandVersion = try values.decodeIfPresent(ModernBuckleVersion.self, forKey: ._bandVersion)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.bandSize, forKey: ._bandSize)
        try super.encode(to: encoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandSize = "bandSize"
        case _bandVersion = "bandVersion"
    }
    
    override func formattedName() -> String {
        var result = super.formattedName()
        
        if self.bandVersion == .fineWoven {
            if result.last == ")" {
                result.removeLast()
                result += ", \(bandVersion.rawValue))"
            }
            else {
                result += " (\(bandVersion.rawValue))"
            }
        }
        
        return result
    }
    
    override func formattedDetails() -> String {
        var result = super.formattedDetails()
        
        if self.bandVersion == .fineWoven {
            if result.count == 0 {
                result = bandVersion.rawValue
            }
            else {
                result += ", \(bandVersion.rawValue)"
            }
        }
        
        return result
    }
}

class LeatherLoop : Band {
    private var _bandSize: BandSize?
    var bandSize: BandSize { _bandSize ?? .none }
    
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
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.bandSize, forKey: ._bandSize)
        try super.encode(to: encoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandSize = "bandSize"
    }
}

class LeatherLink : Band {
    private var _bandSize: BandSize?
    var bandSize: BandSize { _bandSize ?? .none }
    
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
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.bandSize, forKey: ._bandSize)
        try super.encode(to: encoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandSize = "bandSize"
    }
}

class MagneticLink : Band {
    private var _bandSize: BandSize?
    var bandSize: BandSize { _bandSize ?? .none }
    
    enum BandSize: String, Codable {
        case none = "None"
        case smallMedium = "S/M"
        case mediumLarge = "M/L"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize? = nil, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandSize = bandSize
        self.bandType = .MagneticLink
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandSize = try values.decodeIfPresent(BandSize.self, forKey: ._bandSize)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.bandSize, forKey: ._bandSize)
        try super.encode(to: encoder)
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

class AlpineLoop : Band {
    private var _bandSize: BandSize?
    var bandSize: BandSize { _bandSize ?? .none }
    
    enum BandSize: String, Codable {
        case none = "None"
        case small = "S"
        case medium = "M"
        case large = "L"
    }
    
    private var _hardwareFinish: HardwareFinish?
    var hardwareFinish: HardwareFinish { _hardwareFinish ?? .none }
    
    enum HardwareFinish: String, Codable {
        case none = "None"
        case natural = "Natural"
        case black = "Black"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize? = nil, hardwareFinish: HardwareFinish = .none, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandSize = bandSize
        self._hardwareFinish = hardwareFinish
        self.bandType = .AlpineLoop
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandSize = try values.decodeIfPresent(BandSize.self, forKey: ._bandSize)
        _hardwareFinish = try values.decodeIfPresent(HardwareFinish.self, forKey: ._hardwareFinish)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.bandSize, forKey: ._bandSize)
        try container.encode(self.hardwareFinish, forKey: ._hardwareFinish)
        try super.encode(to: encoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandSize = "bandSize"
        case _hardwareFinish = "hardwareFinish"
    }
    
    override func formattedName() -> String {
        var result = super.formattedName()
        
        if self.hardwareFinish == .natural || self.hardwareFinish == .black {
            if result.last == ")" {
                result.removeLast()
                result += ", \(hardwareFinish.rawValue) Hardware)"
            }
            else {
                result += " (\(hardwareFinish.rawValue) Hardware)"
            }
        }
        
        return result
    }
    
    override func formattedDetails() -> String {
        var result = super.formattedDetails()
        
        if self.hardwareFinish == .natural || self.hardwareFinish == .black {
            if result.count == 0 {
                result = hardwareFinish.rawValue + " Hardware"
            }
            else {
                result += ", \(hardwareFinish.rawValue) Hardware"
            }
        }
        
        return result
    }
}

class TrailLoop : Band {
    private var _bandSize: BandSize?
    var bandSize: BandSize { _bandSize ?? .none }
    
    enum BandSize: String, Codable {
        case none = "None"
        case smallMedium = "S/M"
        case mediumLarge = "M/L"
    }
    
    private var _hardwareFinish: HardwareFinish?
    var hardwareFinish: HardwareFinish { _hardwareFinish ?? .none }
    
    enum HardwareFinish: String, Codable {
        case none = "None"
        case natural = "Natural"
        case black = "Black"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize? = nil, hardwareFinish: HardwareFinish = .none, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandSize = bandSize
        self._hardwareFinish = hardwareFinish
        self.bandType = .TrailLoop
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandSize = try values.decodeIfPresent(BandSize.self, forKey: ._bandSize)
        _hardwareFinish = try values.decodeIfPresent(HardwareFinish.self, forKey: ._hardwareFinish)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.bandSize, forKey: ._bandSize)
        try container.encode(self.hardwareFinish, forKey: ._hardwareFinish)
        try super.encode(to: encoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandSize = "bandSize"
        case _hardwareFinish = "hardwareFinish"
    }
    
    override func formattedName() -> String {
        var result = super.formattedName()
        
        if self.hardwareFinish == .natural || self.hardwareFinish == .black {
            if result.last == ")" {
                result.removeLast()
                result += ", \(hardwareFinish.rawValue) Hardware)"
            }
            else {
                result += " (\(hardwareFinish.rawValue) Hardware)"
            }
        }
        
        return result
    }
    
    override func formattedDetails() -> String {
        var result = super.formattedDetails()
        
        if self.hardwareFinish == .natural || self.hardwareFinish == .black {
            if result.count == 0 {
                result = hardwareFinish.rawValue + " Hardware"
            }
            else {
                result += ", \(hardwareFinish.rawValue) Hardware"
            }
        }
        
        return result
    }
}

class OceanBand : Band {
    private var _hardwareFinish: HardwareFinish?
    var hardwareFinish: HardwareFinish { _hardwareFinish ?? .none }
    
    enum HardwareFinish: String, Codable {
        case none = "None"
        case natural = "Natural"
        case black = "Black"
    }
    
    init(color: String, season: Season, year: Int, hardwareFinish: HardwareFinish = .none, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._hardwareFinish = hardwareFinish
        self.bandType = .OceanBand
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _hardwareFinish = try values.decodeIfPresent(HardwareFinish.self, forKey: ._hardwareFinish)
    }
    
    override func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.hardwareFinish, forKey: ._hardwareFinish)
        try super.encode(to: encoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _hardwareFinish = "hardwareFinish"
    }
    
    override func formattedName() -> String {
        var result = super.formattedName()
        
        if self.hardwareFinish == .natural || self.hardwareFinish == .black {
            if result.last == ")" {
                result.removeLast()
                result += ", \(hardwareFinish.rawValue) Hardware)"
            }
            else {
                result += " (\(hardwareFinish.rawValue) Hardware)"
            }
        }
        
        return result
    }
    
    override func formattedDetails() -> String {
        var result = super.formattedDetails()
        
        if self.hardwareFinish == .natural || self.hardwareFinish == .black {
            if result.count == 0 {
                result = hardwareFinish.rawValue + " Hardware"
            }
            else {
                result += ", \(hardwareFinish.rawValue) Hardware"
            }
        }
        
        return result
    }
}

class TitaniumMilaneseLoop : Band {
    private var _bandSize: BandSize?
    var bandSize: BandSize { _bandSize ?? .none }
    
    enum BandSize: String, Codable {
        case none = "None"
        case small = "S"
        case medium = "M"
        case large = "L"
    }
    
    init(color: String, season: Season, year: Int, bandSize: BandSize? = nil, generation: Int? = nil) {
        super.init(color: color, season: season, year: year, generation: generation)
        self._bandSize = bandSize
        self.bandType = .TitaniumMilaneseLoop
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _bandSize = try values.decodeIfPresent(BandSize.self, forKey: ._bandSize)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.bandSize, forKey: ._bandSize)
        try super.encode(to: encoder)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case bandType, color, season, year, generation, edition, colorOrder, dateOrder, logicalOrder, size, isOwned
        case _bandSize = "bandSize"
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
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.manufacturer, forKey: .manufacturer)
        try super.encode(to: encoder)
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
