//
//  StatsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        NavigationView {
            VStack(
                alignment: .leading
            ) {
                List(SampleWatchBands) {
                    WatchBandView(watchBand: $0.self)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationTitle("Stats")
        }
    }
    
    

}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}


private var SampleWatchBands = [
    WatchBand(bandType: BandType.SportBand, color: "Capri Blue", generation: 0, season: Season.spring, year: 2021),
    WatchBand(bandType: BandType.ClassicBuckle, color: "Cosmos Blue", generation: 0, season: Season.fall, year: 2017),
    WatchBand(bandType: BandType.SportBand, color: "Plum", generation: 0, season: Season.winter, year: 2020),
]
