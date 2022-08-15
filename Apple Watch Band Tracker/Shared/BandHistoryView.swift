//
//  BandHistoryView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/13/22.
//

import SwiftUI

struct BandHistoryView : View {
    let bandHistory: BandHistory
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                BandView(band: bandHistory.band, showBandType: true, showIcon: true)
                Text(bandHistory.timeWornString())
            }
        }
    }
}

struct BandHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BandHistoryView(bandHistory: BandHistoryRepository.sample.bandHistories[0])
    }
}
