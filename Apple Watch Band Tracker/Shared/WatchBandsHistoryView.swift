//
//  WatchBandsHistoryView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 4/9/23.
//

import SwiftUI

struct WatchBandsHistoryView: View {
    //    init() {
    //        Theme.navigationBarColors(background: .blue, titleColor: .white)
    //    }
        
    // define the repositories that this view will use
    private var repository: BandHistoryRepository
    private var bandRepository: BandRepository
    
    init(watch: Watch? = nil) {
        if watch == nil {
            self.bandRepository = BandRepository.sample
            self.repository = BandHistoryRepository.sample
            self.watch = WatchRepository.sample.allWatches[0]
        }
        else {
            self.bandRepository = BandRepository.default
            self.repository = BandHistoryRepository.default
            self.watch = watch!
        }
    }
    
    var watch: Watch
    var pageTitle: String {
        watch.formattedName()
    }
        
    @State private var showTrackBandSheet = false
    @State private var showingAlert = false
        
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            List {
                ForEach(repository.getHistoriesForWatch(watch: watch)) { item in
                    NavigationLink {
                        BandHistoryDetailsView(bandHistory: item.self)
                    } label: {
                        BandHistoryView(bandHistory: item.self)
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            let wasSuccessful = BandHistoryRepository.default.removeBandHistory(bandHistory: item)
                            
                            if !wasSuccessful {
                                showingAlert = true
                            }
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
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Unable to Delete Band History"),
                message: Text("There was an error deleting the band history, it may not have been deleted."),
                dismissButton: .default(Text("OK")))
        }
    }
}

struct WatchBandsHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        WatchBandsHistoryView()
    }
}
