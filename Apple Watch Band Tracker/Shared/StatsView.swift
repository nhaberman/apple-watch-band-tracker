//
//  StatsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/11/22.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            List {
                ForEach(WatchRepository.sample.allWatches) { watch     in
                    WatchView(watch: watch)
                }
            }
            .listStyle(.insetGrouped)
            
            List {
//                HStack {
//                    Text("Sport Bands")
//                    Spacer()
//                    Text(String(BandRepository.default.allBands.sportBands.count))
//                }
//                HStack {
//                    Text("Nike Sport Bands")
//                    Spacer()
//                    Text(String(BandRepository.default.allBands.nikeSportBands.count))
//                }
//                HStack {
//                    Text("Sport Loops")
//                    Spacer()
//                    Text(String(BandRepository.default.allBands.sportLoops.count))
//                }
//                HStack {
//                    Text("Nike Sport Loops")
//                    Spacer()
//                    Text(String(BandRepository.default.allBands.nikeSportLoops.count))
//                }
//                HStack {
//                    Text("Solo Loops")
//                    Spacer()
//                    Text(String(BandRepository.default.allBands.soloLoops.count))
//                }
//                HStack {
//                    Text("Braided Solo Loops")
//                    Spacer()
//                    Text(String(BandRepository.default.allBands.braidedSoloLoops.count))
//                }
//                HStack {
//                    Text("Woven Nylons")
//                    Spacer()
//                    Text(String(BandRepository.default.allBands.wovenNylons.count))
//                }
//                HStack {
//                    Text("Classic Buckles")
//                    Spacer()
//                    Text(String(BandRepository.default.allBands.classicBuckles.count))
//                }
//                HStack {
//                    Text("Modern Buckles")
//                    Spacer()
//                    Text(String(BandRepository.default.allBands.modernBuckles.count))
//                }
                HStack {
                    Text("Leather Loops")
                    Spacer()
//                    Text(String(BandRepository.default.allBands.leatherLoops.count))
                }
                HStack {
                    Text("Leather Links")
                    Spacer()
//                    Text(String(BandRepository.default.allBands.leatherLinks.count))
                }
//                HStack {
//                    Text("Milanese Loops")
//                    Spacer()
//                    Text(String(BandRepository.default.allBands.milaneseLoops.count))
//                }
//                HStack {
//                    Text("Link Bracelets")
//                    Spacer()
//                    Text(String(BandRepository.default.allBands.linkBracelets.count))
//                }
//                HStack {
//                    Text("Third Party Bands")
//                    Spacer()
//                    Text(String(BandRepository.default.allBands.thirdPartyBands.count))
//                }
            }
            
            
        }
        .navigationTitle("All Watches")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
