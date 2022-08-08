//
//  HistoryView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct HistoryView: View {
    init() {
        //Theme.navigationBarColors(background: .blue, titleColor: .white)
    }
    
    @State private var showTrackBandSheet = false
    @State private var showSettingsSheet = false
    
    var body: some View {
        NavigationView {
            VStack(
                alignment: .leading
            ) {
                List {
                    ForEach(SampleWatchBandHistoriesGrouped) { item in
                        Section(header: Text(item.historyDate)) {
                            ForEach(item.WatchBandHistories) { subItem in
                                WatchBandHistoryView(watchBandHistory: subItem.self)
                            }
                        }
                    }
                }
                
                
                
                
//                List(SampleWatchBandHistories) {
//                    WatchBandHistoryView(watchBandHistory: $0.self)
//                    Text($0.self.dateWorn)
//                }
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationTitle("Band History")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("tapped settings")
                        showSettingsSheet = true
                    } label: {
                        Label("Settings", systemImage: "gear.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("tapped track band")
                        showTrackBandSheet = true
                    } label: {
                        Label("Track Band", systemImage: "plus.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $showTrackBandSheet, onDismiss: {
            print("goodbye track band sheet")
        }, content: {
            TrackBandView()
        })
        .sheet(isPresented: $showSettingsSheet, onDismiss: {
            print("goodbye settings sheet")
        }, content: {
            SettingsView()
        })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}


struct HistoryDate: Identifiable {
    let historyDate: String
    let WatchBandHistories: [WatchBandHistory]
    let id = UUID()
}
                

private let SampleWatchBandHistories = [
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
    WatchBandHistory(
        watchBand: WatchBand(
            bandType: BandType.ClassicBuckle,
            color: "Cosmos Blue",
            generation: 4,
            season: Season.fall,
            year: 2017),
        timeWorn: Date(timeIntervalSinceNow: -200000)),
    WatchBandHistory(
        watchBand: WatchBand(
            bandType: BandType.SportBand,
            color: "Plum",
            season: Season.winter,
            year: 2020),
        timeWorn: Date(timeIntervalSinceNow: -225000)),
    WatchBandHistory(
        watchBand: WatchBand(
            bandType: BandType.SportLoop,
            color: "Midnight Blue",
            generation: 2,
            season: Season.fall,
            year: 2019),
        timeWorn: Date(timeIntervalSinceNow: -260000)),
    WatchBandHistory(
        watchBand: WatchBand(
            bandType: BandType.ClassicBuckle,
            color: "Dark Aubergine",
            generation: 4,
            season: Season.fall,
            year: 2017),
        timeWorn: Date(timeIntervalSinceNow: -320000)),
    WatchBandHistory(
        watchBand: WatchBand(
            bandType: BandType.BraidedSoloLoop,
            color: "Bright Green",
            season: Season.spring,
            year: 2022),
        timeWorn: Date(timeIntervalSinceNow: -330000)),
]



func groupByDate() -> [HistoryDate] {
    var results = [HistoryDate]()
    
    let allDates: [String] = SampleWatchBandHistories.map { history in
        history.dateWorn
    }
    
    let distinctDates = Array(Set(allDates))
    
    for date in distinctDates {
        let histories = SampleWatchBandHistories.filter {item in
            item.dateWorn == date
        }
        
        let itemToAdd = HistoryDate(historyDate: date, WatchBandHistories: histories)
        
        results.append(itemToAdd)
    }
    
    return results
}

private let SampleWatchBandHistoriesGrouped: [HistoryDate] = groupByDate()

