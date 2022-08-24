//
//  BandHistory.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import Foundation
import SwiftUI

class BandHistory: Identifiable, Comparable, Hashable, Codable {
    static func == (lhs: BandHistory, rhs: BandHistory) -> Bool {
        return lhs.band == rhs.band
            && lhs.watch == rhs.watch
            && lhs.timeWorn == rhs.timeWorn
    }
    
    static func < (lhs: BandHistory, rhs: BandHistory) -> Bool {
        return lhs.timeWorn < rhs.timeWorn
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(band)
        hasher.combine(watch)
        hasher.combine(timeWorn)
    }
    
    var band: Band
    var bandID: UUID
    var watch: Watch
    var timeWorn: Date
    
    var dateWorn: Date {
        get {
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: timeWorn)
            return Calendar.current.date(from: dateComponents)!
        }
    }
    
    init(band: Band, watch: Watch, timeWorn: Date) {
        self.band = band
        self.bandID = band.bandID
        self.watch = watch
        self.timeWorn = timeWorn
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bandID = try container.decode(UUID.self, forKey: .bandID)
        watch = try container.decode(Watch.self, forKey: .watch)
        timeWorn = try container.decode(Date.self, forKey: .timeWorn)
        band = BandRepository.default.getBandByID(bandID)!
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.bandID, forKey: .bandID)
        try container.encode(self.watch, forKey: .watch)
        try container.encode(self.timeWorn, forKey: .timeWorn)
        
        // create a BandSlim to encode a copy of the band
        let bandSlim = BandSlim(band)
        try container.encode(bandSlim, forKey: .band)
    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case band, watch, timeWorn, bandID
    }
    
    func timeWornString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: self.timeWorn)
    }
    
    struct BandSlim: Encodable {
        var bandType: BandType
        var color: String
        var season: Season? = nil
        var year: Int? = nil
        var generation: Int? = nil
        var edition: String? = nil
        var watchSize: Int? = nil
        var bandSize: String? = nil
        var pin: String? = nil
        var bandVersion: String? = nil
        var manufacturer: String? = nil
        
        init(_ band: Band) {
            self.bandType = band.bandType
            self.color = band.color
            self.season = band.season
            self.year = band.year
            self.generation = band.generation
            self.edition = band.edition
            self.watchSize = band.watchSize
            
            // set default values for optional properties
            self.bandSize = nil
            self.pin = nil
            self.bandVersion = nil
            self.manufacturer = nil
            
            // add optional properties depending on the band type
            if band.bandType == .SportBand {
                self.pin = (band as! SportBand).pin
            }
            else if band.bandType == .NikeSportBand {
                self.pin = (band as! NikeSportBand).pin
            }
            else if band.bandType == .SportLoop {
                self.bandVersion = (band as! SportLoop).bandVersion.rawValue
            }
            else if band.bandType == .NikeSportLoop {
                self.bandVersion = (band as! NikeSportLoop).bandVersion.rawValue
            }
            else if band.bandType == .SoloLoop {
                if let bandSize = (band as! SoloLoop).bandSize {
                    self.bandSize = String(bandSize)
                }
            }
            else if band.bandType == .BraidedSoloLoop {
                if let bandSize = (band as! BraidedSoloLoop).bandSize {
                    self.bandSize = String(bandSize)
                }
            }
            else if band.bandType == .WovenNylon {
                self.bandVersion = (band as! WovenNylon).bandVersion.rawValue
            }
            else if band.bandType == .ModernBuckle {
                self.bandVersion = (band as! ModernBuckle).bandSize.rawValue
            }
            else if band.bandType == .LeatherLoop {
                self.bandVersion = (band as! LeatherLoop).bandSize.rawValue
            }
            else if band.bandType == .LeatherLink {
                self.bandVersion = (band as! LeatherLink).bandSize.rawValue
            }
            else if band.bandType == .ThirdPartyBand {
                self.manufacturer = (band as! ThirdPartyBand).manufacturer
            }
        }
    }
}
