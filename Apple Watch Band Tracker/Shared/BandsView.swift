//
//  AllBandsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct BandsView: View {
    init() {
        //Theme.navigationBarColors(background: .blue, titleColor: .white)
    }
    
    @State private var showSettingsSheet = false
    
    var body: some View {
        NavigationView {
            VStack(
                alignment: .leading
            ) {
                List(SampleWatchBandHistories) {
                    WatchBandHistoryView(watchBandHistory: $0.self)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationTitle("Watch Bands")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("tapped settings")
                        showSettingsSheet = true
                    } label: {
                        Label("Settings", systemImage: "gear.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $showSettingsSheet, onDismiss: {
            print("goodbye settings sheet")
        }, content: {
            SettingsView()
        })
    }
}

struct BandsView_Previews: PreviewProvider {
    static var previews: some View {
        BandsView()
    }
}

private var SampleWatchBandHistories = [
    WatchBandHistory(
        watchBand: WatchBand(
            bandType: BandType.SportBand,
            color: "Capri Blue",
            season: Season.spring,
            year: 2021),
        timeWorn: Date(timeIntervalSinceNow: -60)),
    WatchBandHistory(
        watchBand: WatchBand(
            bandType: BandType.ClassicBuckle,
            color: "Cosmos Blue",
            generation: 4,
            season: Season.fall,
            year: 2017),
        timeWorn: Date(timeIntervalSinceNow: -6000)),
    WatchBandHistory(
        watchBand: WatchBand(
            bandType: BandType.SportBand,
            color: "Plum",
            season: Season.winter,
            year: 2020),
        timeWorn: Date(timeIntervalSinceNow: -40000)),
    WatchBandHistory(
        watchBand: WatchBand(
            bandType: BandType.SportLoop,
            color: "Midnight Blue",
            generation: 2,
            season: Season.fall,
            year: 2019),
        timeWorn: Date(timeIntervalSinceNow: -120000)),
    WatchBandHistory(
        watchBand: WatchBand(
            bandType: BandType.ClassicBuckle,
            color: "Dark Aubergine",
            generation: 4,
            season: Season.fall,
            year: 2017),
        timeWorn: Date(timeIntervalSinceNow: -140000)),
    WatchBandHistory(
        watchBand: WatchBand(
            bandType: BandType.BraidedSoloLoop,
            color: "Bright Green",
            season: Season.spring,
            year: 2022),
        timeWorn: Date(timeIntervalSinceNow: -185000)),
]
