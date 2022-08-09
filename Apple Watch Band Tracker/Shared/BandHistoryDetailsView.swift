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
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                BandView(band: bandHistory.band)
                WatchView(watch: bandHistory.watch)
                Text(bandHistory.timeWornString())
            }
        }
    }
}

struct BandHistoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BandHistoryDetailsView(bandHistory: BandHistory())
    }
}
