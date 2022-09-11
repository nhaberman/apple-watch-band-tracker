//
//  BandHistoryView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/15/22.
//

import SwiftUI

struct BandsHistoryView: View {
    //    init() {
    //        Theme.navigationBarColors(background: .blue, titleColor: .white)
    //    }
        
    // define the repositories that this view will use
    private var repository: BandHistoryRepository
    private var bandRepository: BandRepository
    
    init(band: Band? = nil) {
        if band == nil {
            self.bandRepository = BandRepository.sample
            self.repository = BandHistoryRepository.sample
            self.band = bandRepository.allBands[0]
        }
        else {
            self.bandRepository = BandRepository.default
            self.repository = BandHistoryRepository.default
            self.band = band!
        }
    }
    
    var band: Band
    var pageTitle: String {
        band.formattedName()
    }
        
    @State private var showTrackBandSheet = false
        
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            List {
                ForEach(repository.getHistoriesForBand(band: band)) { item in
                    NavigationLink {
                        BandHistoryDetailsView(bandHistory: item.self)
                    } label: {
                        BandHistoryView(bandHistory: item.self)
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        print("test delete")
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .swipeActions {
                    Button {
                        print("test edit")
                    } label: {
                        Label("Edit", systemImage: "square.and.pencil")
                    }
                    .tint(.blue)
                }
            }
            .refreshable(action: {
                // code to refresh the list
            })
            .listStyle(.insetGrouped)
        }
        .navigationTitle(pageTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    print("tapped track band")
                    showTrackBandSheet = true
                } label: {
                    Label("Track Band", systemImage: "plus.circle")
                }
            }
            ToolbarItem(placement: ToolbarItemPlacement.status) {
                Button {
                    print("test save as owned")
                } label: {
                    Label("Owned", systemImage: "bag.badge.plus") //bag.badge.minus
                }
            }
            ToolbarItem(placement: .status) {
                Button {
                    print("test save as favorite")
                } label: {
                    Label("Favorite", systemImage: "star.fill")   //star.slash.fill
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

struct BandsHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BandsHistoryView()
    }
}
