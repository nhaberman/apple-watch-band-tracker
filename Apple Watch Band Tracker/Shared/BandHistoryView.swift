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
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "applewatch")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40, alignment: .center)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(bandHistory.watch.getDisplayColor())
                BandView(band: bandHistory.band, showBandType: true, showIcon: false)
                    .frame(alignment:.leading)
            }
            Divider()
            Text(bandHistory.timeWornString())
                .font(.system(size: 14, weight: .medium, design: .rounded))
        }
        .padding(5)
    }
}

struct BandHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BandHistoryView(bandHistory: BandHistoryRepository.sample.bandHistories[4])
    }
}
