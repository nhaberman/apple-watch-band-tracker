//
//  BandHistoryDetailsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/9/22.
//

import SwiftUI

struct BandHistoryDetailsView: View {
    
    var bandHistory : BandHistory
    
    init(bandHistory: BandHistory) {
        self.bandHistory = bandHistory
    }
    
    @State private var showEditBandSheet = false
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section("Band") {
                    BandView(band: bandHistory.band)
                }
                Section("Watch") {
                    WatchView(watch: bandHistory.watch)
                }
                Section("Time Worn") {
                    Text(bandHistory.timeWornString())
                }
            }
        }
        .navigationTitle("Band")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(role: .destructive) {
                    print("tapped delete band")
                    // delete band
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .buttonStyle(.borderless)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("tapped edit band")
                    showEditBandSheet = true
                } label: {
                    Label("Edit", systemImage: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showEditBandSheet, onDismiss: {
            print("goodbye track band sheet")
        }, content: {
            TrackBandView()
        })
    }
}

struct BandHistoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BandHistoryDetailsView(bandHistory: BandHistory())
    }
}
