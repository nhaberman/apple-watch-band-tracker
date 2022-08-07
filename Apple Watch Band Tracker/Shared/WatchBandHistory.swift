//
//  WatchBandHistory.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import Foundation
import SwiftUI

class WatchBandHistory: Identifiable {
    
    var watchBand: WatchBand
    var timeWorn: Date
    
    init(watchBand: WatchBand, timeWorn: Date) {
        self.watchBand = watchBand
        self.timeWorn = timeWorn
    }
    
    func timeWornString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: self.timeWorn)
    }
}

struct WatchBandHistoryView : View {
    let watchBandHistory: WatchBandHistory
    
    var body: some View {
        HStack {
            Image(systemName: "applewatch.side.right")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
            VStack(alignment: .leading) {
                WatchBandView(watchBand: watchBandHistory.watchBand)
                Text(watchBandHistory.timeWornString())
            }
        }
    }
}

struct WatchBandHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        WatchBandHistoryView(watchBandHistory: WatchBandHistory(
            watchBand: WatchBand(
                bandType: BandType.SportLoop,
                color: "Midnight Blue",
                generation: 2,
                season: Season.spring,
                year: 2021),
            timeWorn: Date()))
    }
}
