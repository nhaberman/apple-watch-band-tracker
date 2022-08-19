//
//  StatsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct StatsMainView: View {
//    init() {
//        Theme.navigationBarColors(background: .blue, titleColor: .white)
//    }
    
    // define the repositories that this view will use
    private var repository: BandHistoryRepository
    
    init(_ isPreview: Bool = false) {
        if isPreview {
            self.repository = BandHistoryRepository.sample
        }
        else {
            self.repository = GlobalBandHistoryRepository
        }
    }
    
    @State private var showTrackBandSheet = false
    @State private var showSettingsSheet = false
    
    var body: some View {
        NavigationView {
            VStack(
                alignment: .leading
            ) {
                // put stats stuff here
                Form {
                    List {
                        NavigationLink {
                            StatsView()
                        } label: {
                            Label("Watches", systemImage: "applewatch.watchface")
                        }
                    }
                    
                    if let currentBandHistory = GlobalBandHistoryRepository.getCurrentBand() {
                        Section("Current Band") {
                            BandHistoryView(bandHistory: currentBandHistory)
                        }
                        
                        let mostRecentWornBand = GlobalBandHistoryRepository.getHistoriesForBand(band: currentBandHistory.band)
                        
                        if mostRecentWornBand.count >= 2 {
                            let mostRecentBeforeNow = mostRecentWornBand[1]
                            
                            Section("Last worn on:") {
                                BandHistoryView(bandHistory: mostRecentBeforeNow)
                            }
                        }
                    }
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("tapped track band")
                        showTrackBandSheet = true
                    } label: {
                        Label("Track Band", systemImage: "plus.circle")
                    }
                }
            }
            
            Label("Please select something to begin...", systemImage: "sparkles.rectangle.stack")
        }
        .sheet(isPresented: $showSettingsSheet, onDismiss: {
            print("goodbye settings sheet")
        }, content: {
            SettingsView()
        })
        .sheet(isPresented: $showTrackBandSheet, onDismiss: {
            print("goodbye track band sheet")
        }, content: {
            TrackBandView()
        })
    }
}

struct StatsMainView_Previews: PreviewProvider {
    static var previews: some View {
        StatsMainView(false)
    }
}
