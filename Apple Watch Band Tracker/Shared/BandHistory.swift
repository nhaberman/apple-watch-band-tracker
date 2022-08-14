//
//  BandHistory.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import Foundation
import SwiftUI

class BandHistory: Identifiable, Hashable, Decodable, Encodable {
    static func == (lhs: BandHistory, rhs: BandHistory) -> Bool {
        return lhs.band == rhs.band
            && lhs.watch == rhs.watch
            && lhs.timeWorn == rhs.timeWorn
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
    
    func timeWornString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: self.timeWorn)
    }
}
