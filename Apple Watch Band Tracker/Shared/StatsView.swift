//
//  StatsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct StatsView: View {
    init() {
        //Theme.navigationBarColors(background: .blue, titleColor: .white)
    }
    
    @State private var showSettingsSheet = false
    
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

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}


private var SampleWatchBands = [
    WatchBand(
        bandType: BandType.SportBand,
        color: "Capri Blue",
        season: Season.spring,
        year: 2021),
    WatchBand(
        bandType: BandType.ClassicBuckle,
        color: "Saddle Brown",
        generation: 3,
        season: Season.fall,
        year: 2017),
    WatchBand(
        bandType: BandType.SportBand,
        color: "Plum",
        season: Season.winter,
        year: 2020),
]
