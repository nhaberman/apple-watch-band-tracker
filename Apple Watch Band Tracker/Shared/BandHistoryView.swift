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
        BandHistoryView(bandHistory: BandHistory(
            band: SportLoop(
                color: "Midnight Blue",
                season: .fall,
                year: 2019,
                bandVersion: .twoTone,
                generation: 2),
            watch: Watch(
                series: 7,
                color: "Titanium",
                size: 45,
                edition: "Edition"
            ),
            timeWorn: Date()))
    }
}
