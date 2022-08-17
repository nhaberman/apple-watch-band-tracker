//
//  BandsTypeView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/11/22.
//

import SwiftUI

struct BandsView: View {
    
    // define the repositories that this view will use
    private var bandRepository: BandRepository
    
    init(bandType: BandType? = nil) {
        if bandType == nil {
            self.bandType = .SportBand
            self.bandRepository = BandRepository.sample
        }
        else {
            self.bandType = bandType!
            self.bandRepository = GlobalBandRepository
        }
    }
    
    var bandType : BandType
    
    @State private var showTrackBandSheet = false
    @State private var selectedSortOrder = BandSortOrder.date
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker("Sort Order", selection: $selectedSortOrder) {
                ForEach(BandSortOrder.allCases) { bandSortOrder in
                    Text(bandSortOrder.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            
            List {
                ForEach(bandRepository.getBandsByType(bandType, sortOrder: selectedSortOrder)) { band in
                    NavigationLink {
                        BandsHistoryView(band: band)
                    } label: {
                        BandView(band: band, showBandType: false)
                    }
                }
            }
        }
        .navigationTitle(bandType.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
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
    }
}

struct BandsView_Previews: PreviewProvider {
    static var previews: some View {
        BandsView()
    }
}
