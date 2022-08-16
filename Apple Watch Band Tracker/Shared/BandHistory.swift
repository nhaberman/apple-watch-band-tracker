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
        self.watch = watch
        self.timeWorn = timeWorn
    }
    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        watch = try container.decode(Watch.self, forKey: .watch)
//        timeWorn = try container.decode(Date.self, forKey: .timeWorn)
//
//        // decode the band depending on the type
//        if let object = try? container.decode(SportBand.self, forKey: .band) {
//            band = object
//        } else if let object = try? container.decode(NikeSportBand.self, forKey: .band) {
//            band = object
//        } else if let object = try? container.decode(SportLoop.self, forKey: .band) {
//            band = object
//        } else if let object = try? container.decode(NikeSportLoop.self, forKey: .band) {
//            band = object
//        } else if let object = try? container.decode(SoloLoop.self, forKey: .band) {
//            band = object
//        } else if let object = try? container.decode(BraidedSoloLoop.self, forKey: .band) {
//            band = object
//        } else if let object = try? container.decode(WovenNylon.self, forKey: .band) {
//            band = object
//        } else if let object = try? container.decode(ClassicBuckle.self, forKey: .band) {
//            band = object
//        } else if let object = try? container.decode(ModernBuckle.self, forKey: .band) {
//            band = object
//        } else if let object = try? container.decode(LeatherLoop.self, forKey: .band) {
//            band = object
//        } else if let object = try? container.decode(LeatherLink.self, forKey: .band) {
//            band = object
//        } else if let object = try? container.decode(MilaneseLoop.self, forKey: .band) {
//            band = object
//        } else if let object = try? container.decode(LinkBracelet.self, forKey: .band) {
//            band = object
//        } else if let object = try? container.decode(ThirdPartyBand.self, forKey: .band) {
//            band = object
//        } else {
//            band = try container.decode(Band.self, forKey: .band)
//        }
//    }
    
    // coding keys for specific band properties
    enum CodingKeys: String, CodingKey {
        case band, watch, timeWorn
    }
    
    func timeWornString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: self.timeWorn)
    }
}
