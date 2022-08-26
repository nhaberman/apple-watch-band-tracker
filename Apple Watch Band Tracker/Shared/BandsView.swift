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
        self.bandRepository = bandType == nil ? BandRepository.sample : BandRepository.default
        
        _selectedSortOrder = .init(initialValue: bandRepository.defaultSortOrder)
        _selectedSortDirection = .init(initialValue: bandRepository.defaultSortDirection)
    }
    
    var bandType : BandType
    
    @State private var showTrackBandSheet = false
    @State private var selectedSortOrder: BandSortOrder
    @State private var selectedSortDirection: SortOrder
    @State private var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                let bandsByType = bandRepository.getBandsByType(bandType, sortOrder: selectedSortOrder, sortDirection: selectedSortDirection)
                
                ForEach(searchText == "" ? bandsByType : bandsByType.filter({ $0.color.contains(searchText)}), id: \.self) { band in
                    if(band.isOwned) {
                        NavigationLink {
                            BandsHistoryView(band: band)
                        } label: {
                            BandView(band: band, showBandType: false)
                                .frame(height: 32)
                        }
                        .swipeActions {
                            Button {
                                band.isFavorite.toggle()
                                BandRepository.default.saveFavoriteBands()
                            } label: {
                                Label("Favorite", systemImage: "star.fill")   //star.slash.fill
                            }
                            .tint(.purple)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
        }
        .navigationTitle(bandType.rawValue)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("tapped track band")
                    showTrackBandSheet = true
                } label: {
                    Label("Track Band", systemImage: "plus.circle")
                }
            }
            ToolbarItem(placement: ToolbarItemPlacement.status) {
                HStack(alignment: .lastTextBaseline) {
                    Text("Sort By:")
                        .font(Font.custom("System", size: 14, relativeTo: .body))
                    Picker("Sort Order", selection: $selectedSortOrder) {
                        ForEach(BandSortOrder.allCases) { bandSortOrder in
                            Text(bandSortOrder.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.menu)
                    Spacer(minLength: 25)
                    Picker("Sort Direction", selection: $selectedSortDirection) {
                        Text("Asc").tag(SortOrder.forward)
                        Text("Desc").tag(SortOrder.reverse)
                    }
                    .pickerStyle(.segmented)
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
