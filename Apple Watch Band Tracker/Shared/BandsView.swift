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
        self.bandType = bandType ?? .ClassicBuckle
        self.bandRepository = bandType == nil ? BandRepository.sample : GlobalBandRepository
    }
    
    var bandType : BandType
    
    @State private var showTrackBandSheet = false
    @State private var selectedSortOrder = BandSortOrder.date
    @State private var selectedSortDirection = SortOrder.forward
    @State private var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .lastTextBaseline) {
                Text("Sort By:")
                    .font(.system(size: 14))
                Picker("Sort Order", selection: $selectedSortOrder) {
                    ForEach(BandSortOrder.allCases) { bandSortOrder in
                        Text(bandSortOrder.rawValue.capitalized)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 100, alignment: .leading)
                Picker("Sort Direction", selection: $selectedSortDirection) {
                    Text("Asc").tag(SortOrder.forward)
                    Text("Desc").tag(SortOrder.reverse)
                }
                .pickerStyle(.segmented)
            }
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            
            
            List {
                let bandsByType = bandRepository.getBandsByType(bandType, sortOrder: selectedSortOrder, sortDirection: selectedSortDirection)
                
                ForEach(searchText == "" ? bandsByType : bandsByType.filter({ $0.color.contains(searchText)}), id: \.self) { band in
                    if(band.isOwned ?? false) {
                        NavigationLink {
                            BandsHistoryView(band: band)
                        } label: {
                            BandView(band: band, showBandType: false)
                                .frame(height: 32)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
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
