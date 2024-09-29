//
//  WatchesMainView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 4/9/23.
//

import SwiftUI

struct WatchesMainView: View {
    
    @State private var showTrackBandSheet = false
    @State private var showSettingsSheet = false
    
    var body: some View {
        NavigationStack {
            VStack(
                alignment: .leading
            ) {
                List {
                    ForEach(WatchRepository().allWatches.reversed()) { watch in
                        NavigationLink {
                            WatchBandsHistoryView(watch: watch)
                        } label: {
                            WatchView(watch: watch)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationTitle("Watches")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("tapped settings")
                        showSettingsSheet = true
                    } label: {
                        Label("Settings", systemImage: "gear.circle.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("tapped track band")
                        showTrackBandSheet = true
                    } label: {
                        Label("Track Band", systemImage: "plus.circle.fill")
                    }
                }
            }
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

struct WatchesMainView_Previews: PreviewProvider {
    static var previews: some View {
        WatchesMainView()
    }
}
