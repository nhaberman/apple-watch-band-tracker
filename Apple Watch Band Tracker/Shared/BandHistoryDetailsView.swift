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
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showEditBandSheet = false
    @State private var showingAlert = false
    
    var body: some View {
        List {
            Section("Band") {
                BandView(band: bandHistory.band, showBandType: true, showIcon: true)
                    .frame(minHeight: 75)
            }
            Section("Watch") {
                WatchView(watch: bandHistory.watch)
                    .frame(minHeight: 75)
            }
            Section("Time Worn") {
                Label(bandHistory.timeWornString(), systemImage: "calendar.badge.clock")
            }
        }
        .navigationTitle("Band")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(role: .destructive) {
                    print("tapped delete band")
                    let wasSuccessful = BandHistoryRepository.default.removeBandHistory(bandHistory: bandHistory)
                    
                    if !wasSuccessful {
                        showingAlert = true
                    }
                    else {
                        // dismiss view
                        presentationMode.wrappedValue.dismiss()
                    }
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
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Unable to Delete Band History"),
                message: Text("There was an error deleting the band history, it may not have been deleted."),
                dismissButton: .default(Text("OK")))
        }
    }
}

struct BandHistoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BandHistoryDetailsView(bandHistory: BandHistory(
            band: ClassicBuckle(
                color: "Dark Aubergine",
                season: .fall,
                year: 2017,
                generation: 4),
            watch: Watch(
                series: 0,
                material: .stainlessSteel,
                finish: .silver,
                size: 42),
            timeWorn: Date()))
    }
}
