//
//  ManageWatchesView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/26/22.
//

import SwiftUI

struct ManageWatchesView: View {
    
    private var watchRepository: WatchRepository
    
    @State private var showAddWatchSheet = false
    @State var allWatches: [Watch]
    
    init(_ isPreview: Bool = false) {
        self.watchRepository = isPreview ? WatchRepository.default : WatchRepository.sample
        
        self.allWatches = watchRepository.allWatches
    }
    
    var body: some View {
        List {
            ForEach(allWatches) { watch in
                WatchView(watch: watch)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            print("delete watch")
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
            
            Button {
                print("tapped add watch")
                showAddWatchSheet = true
            } label: {
                Label("Add Watch", systemImage: "applewatch")
            }

        }
        .sheet(isPresented: $showAddWatchSheet, onDismiss: {
            print("goodbye add watch sheet")
        }, content: {
            AddWatchView()
        })
    }
}

struct ManageWatchesView_Previews: PreviewProvider {
    static var previews: some View {
        ManageWatchesView(true)
    }
}
