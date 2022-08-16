//
//  BandHistoryView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/13/22.
//

import SwiftUI

struct BandHistoryView : View {
    let bandHistory: BandHistory
    
    var bandColor = 2
    
    var body: some View {
        HStack {
            Image(systemName: "applewatch.side.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40, alignment: .center)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(bandHistory.watch.getDisplayColor())
            VStack(alignment: .leading) {
                BandView(band: bandHistory.band, showBandType: true, showIcon: false)
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
