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
}

struct WatchBandView : View {
    let watchBand: WatchBand
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(watchBand.bandType.rawValue)
                .fontWeight(Font.Weight.bold)
            Text(watchBand.color)
        }
    }
}
