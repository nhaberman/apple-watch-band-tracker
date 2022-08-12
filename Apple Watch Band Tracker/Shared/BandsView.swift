//
//  BandsTypeView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/11/22.
//

import SwiftUI

struct BandsView: View {
    init(bandType : BandType) {
        self.bandType = bandType
    }
    
    var bandType : BandType
    
    var body: some View {
        VStack(alignment: .leading) {
            let bandRepository = BandRepository()
            let bandList = bandRepository.allBands.filter { item in
                item.bandType == self.bandType
            }
            List {
                ForEach(bandList) { band in
                    NavigationLink {
                        HistoryView(band: band)
                    } label: {
                        BandView(band: band)
                    }
                }
            }
        }
        .navigationTitle(bandType.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BandsView_Previews: PreviewProvider {
    static var previews: some View {
        BandsView(bandType: BandType.SportBand)
    }
}
