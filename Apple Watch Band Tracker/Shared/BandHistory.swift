//
//  BandHistory.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import Foundation
import SwiftUI

class BandHistory: Identifiable {
    
    var band: Band
    var watch: Watch
    var timeWorn: Date
    
    var dateWorn: Date {
        get {
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: timeWorn)
            return Calendar.current.date(from: dateComponents)!
        }
    }
    
    init(band: Band, watch: Watch, timeWorn: Date) {
        self.band = band
        self.watch = watch
        self.timeWorn = timeWorn
    }
    
    init() {
        self.band = Band()
        self.watch = Watch()
        self.timeWorn = Date()
    }
    
    func timeWornString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: self.timeWorn)
    }
}

struct BandHistoryView : View {
    let bandHistory: BandHistory
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                BandView(band: bandHistory.band)
                Text(bandHistory.timeWornString())
            }
        }
    }
}

struct BandHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BandHistoryView(bandHistory: BandHistory(
            band: Band(
                bandType: BandType.SportLoop,
                color: "Midnight Blue",
                generation: 2,
                season: Season.spring,
                year: 2021),
            watch: Watch(
                series: 7,
                color: "Titanium",
                edition: "Edition",
                size: 45
            ),
            timeWorn: Date()))
    }
}
