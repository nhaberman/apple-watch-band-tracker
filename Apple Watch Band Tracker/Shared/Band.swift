//
//  Band.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import Foundation
import SwiftUI

class Band: Identifiable, Hashable {
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
        
    var bandType: BandType
    var color: String
    var pin: String
    var generation: Int
    var season: Season
    var year: Int
    
    init(bandType: BandType, color: String, generation: Int, season: Season, year: Int) {
        self.bandType = bandType
        self.color = color
        self.pin = ""
        self.generation = generation
        self.season = season
        self.year = year
    }
    
    init(bandType: BandType, color: String, season: Season, year: Int) {
        self.bandType = bandType
        self.color = color
        self.pin = ""
        self.generation = 0
        self.season = season
        self.year = year
    }
    
    init() {
        self.bandType = BandType.SportBand
        self.color = "Black"
        self.pin = ""
        self.generation = 0
        self.season = Season.spring
        self.year = 2015
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

struct BandView : View {
    let band: Band
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(band.bandType.rawValue)
                .fontWeight(Font.Weight.bold)
            Text(band.formattedColorName())
        }
    }
}

struct BandView_Previews: PreviewProvider {
    static var previews: some View {
        BandView(band: Band(
            bandType: BandType.ClassicBuckle,
            color: "Saddle Brown",
            generation: 3,
            season: Season.fall,
            year: 2017))
    }
}
