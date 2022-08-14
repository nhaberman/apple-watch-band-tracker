//
//  BandsTypeView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/11/22.
//

import SwiftUI

struct BandsView: View {
    init(repository: BandHistoryRepository, bandType : BandType) {
        self.repository = repository
        self.bandType = bandType
    }
    
    let repository: BandHistoryRepository
    var bandType : BandType
    
    var body: some View {
        VStack(alignment: .leading) {
            let bandRepository = BandRepository()
            
            List {
                ForEach(bandRepository.getBandsByType(bandType)) { band in
                    NavigationLink {
                        HistoryView(repository: repository, band: band)
                    } label: {
                        BandView(band: band, showBandType: false)
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
        BandsView(repository: BandHistoryRepository(false), bandType: BandType.SportBand)
    }
}
