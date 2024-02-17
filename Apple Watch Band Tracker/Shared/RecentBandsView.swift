//
//  RecentBandsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 10/25/23.
//

import SwiftUI

struct RecentBandsView: View {
    
    // define the repositories that this view will use
    private var repository: BandHistoryRepository
    private var bandRepository: BandRepository
    
    init(_ isPreview: Bool = false) {
        if isPreview {
            self.repository = BandHistoryRepository.sample
            self.bandRepository = BandRepository.sample
        }
        else {
            self.repository = BandHistoryRepository.default
            self.bandRepository = BandRepository.default
        }
    }
    
    var body: some View {
        
        let histories = repository.mostRecentHistoriesByBand.values.sorted(by: {$0.timeWorn > $1.timeWorn})
        
        VStack(
            alignment: .leading
        ) {
            List {
                ForEach(histories) { item in
                    BandHistoryView(bandHistory: item.self)
                }
            }
        }
    }
}

#Preview {
    RecentBandsView()
}
