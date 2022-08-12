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
            band: SportLoop(
                color: "Midnight Blue",
                season: .fall,
                year: 2019,
                bandVersion: .thirdGen,
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
