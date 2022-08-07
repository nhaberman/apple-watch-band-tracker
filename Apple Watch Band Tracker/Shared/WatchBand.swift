//
//  WatchBand.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import Foundation
import SwiftUI

class WatchBand: Identifiable {
    
    var bandType: BandType
    var color: String
    var generation: Int
    var season: Season
    var year: Int
    
    init(bandType: BandType, color: String, generation: Int, season: Season, year: Int) {
        self.bandType = bandType
        self.color = color
        self.generation = generation
        self.season = season
        self.year = year
    }
    
    init(bandType: BandType, color: String, season: Season, year: Int) {
        self.bandType = bandType
        self.color = color
        self.generation = 0
        self.season = season
        self.year = year
    }
}

struct WatchBandView : View {
    let watchBand: WatchBand
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(watchBand.bandType.rawValue)
                .fontWeight(Font.Weight.bold)
            
            if (watchBand.generation != 0) {
                Text("\(watchBand.color) (Gen \(watchBand.generation))")
            }
            else {
                Text(watchBand.color)
            }
        }
    }
}

struct WatchBandView_Previews: PreviewProvider {
    static var previews: some View {
        WatchBandView(watchBand: WatchBand(
            bandType: BandType.ClassicBuckle,
            color: "Saddle Brown",
            generation: 3,
            season: Season.fall,
            year: 2017))
    }
}
