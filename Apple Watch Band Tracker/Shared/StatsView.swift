//
//  StatsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/11/22.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            List {
                ForEach(WatchRepository.sample.allWatches) { watch     in
                    WatchView(watch: watch)
                }
            }
            .listStyle(.insetGrouped)
        }
        .navigationTitle("All Watches")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
