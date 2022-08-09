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
    
    init(lookBackDays : Int) {
        self.lookBackDays = lookBackDays
    }
    
    var lookBackDays : Int = 365*100
    var pageTitle : String = "No Title Supplied"
    
    var lookBackDate: Date {
        get {
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date.now)
            let today = Calendar.current.date(from: dateComponents)!
            
            return Date(timeInterval: (Double(lookBackDays * 24 * 20 * 20) * -1), since: today)
        }
    }
    
    @State private var showTrackBandSheet = false
    @State private var showSettingsSheet = false
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            List {
                ForEach(SampleBandHistoriesGrouped) { item in
                    if (item.historyDate > lookBackDate) {
                        Section(header: Text(item.historyDate.formatted(date: .complete, time: .omitted))) {
                            ForEach(item.BandHistories) { subItem in
                                BandHistoryView(bandHistory: subItem.self)
                            }
                        }
                    }
                }
            }
//                List(SampleWatchBandHistories) {
//                    WatchBandHistoryView(watchBandHistory: $0.self)
//                    Text($0.self.dateWorn)
//                }
            .listStyle(.insetGrouped)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .navigationTitle(pageTitle)
        .navigationBarTitleDisplayMode(.inline)
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
    let historyDate: Date
    let BandHistories: [BandHistory]
    let id = UUID()
}
