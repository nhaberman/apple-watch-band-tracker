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
//                    Text(String(GlobalBandRepository.allBands.sportBands.count))
//                }
//                HStack {
//                    Text("Nike Sport Bands")
//                    Spacer()
//                    Text(String(GlobalBandRepository.allBands.nikeSportBands.count))
//                }
//                HStack {
//                    Text("Sport Loops")
//                    Spacer()
//                    Text(String(GlobalBandRepository.allBands.sportLoops.count))
//                }
//                HStack {
//                    Text("Nike Sport Loops")
//                    Spacer()
//                    Text(String(GlobalBandRepository.allBands.nikeSportLoops.count))
//                }
//                HStack {
//                    Text("Solo Loops")
//                    Spacer()
//                    Text(String(GlobalBandRepository.allBands.soloLoops.count))
//                }
//                HStack {
//                    Text("Braided Solo Loops")
//                    Spacer()
//                    Text(String(GlobalBandRepository.allBands.braidedSoloLoops.count))
//                }
//                HStack {
//                    Text("Woven Nylons")
//                    Spacer()
//                    Text(String(GlobalBandRepository.allBands.wovenNylons.count))
//                }
//                HStack {
//                    Text("Classic Buckles")
//                    Spacer()
//                    Text(String(GlobalBandRepository.allBands.classicBuckles.count))
//                }
//                HStack {
//                    Text("Modern Buckles")
//                    Spacer()
//                    Text(String(GlobalBandRepository.allBands.modernBuckles.count))
//                }
                HStack {
                    Text("Leather Loops")
                    Spacer()
//                    Text(String(GlobalBandRepository.allBands.leatherLoops.count))
                }
                HStack {
                    Text("Leather Links")
                    Spacer()
//                    Text(String(GlobalBandRepository.allBands.leatherLinks.count))
                }
//                HStack {
//                    Text("Milanese Loops")
//                    Spacer()
//                    Text(String(GlobalBandRepository.allBands.milaneseLoops.count))
//                }
//                HStack {
//                    Text("Link Bracelets")
//                    Spacer()
//                    Text(String(GlobalBandRepository.allBands.linkBracelets.count))
//                }
//                HStack {
//                    Text("Third Party Bands")
//                    Spacer()
//                    Text(String(GlobalBandRepository.allBands.thirdPartyBands.count))
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
