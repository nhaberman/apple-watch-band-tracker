//
//  BandView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/12/22.
//

import SwiftUI

struct BandView : View {
    init(band: Band, showBandType: Bool = false, showIcon: Bool = false) {
        self.band = band
        self.showBandType = showBandType
        self.showIcon = showIcon
    }
    
    var band: Band
    var showBandType: Bool
    var showIcon: Bool
    
    var body: some View {
        HStack{
            if showIcon {
                Image(systemName: "applewatch.side.right")
                    .aspectRatio(contentMode: .fill)
            }
            VStack(alignment: .leading) {
                if showBandType {
                    Text(band.bandType.rawValue)
                        .fontWeight(Font.Weight.bold)
                }
                Text(band.color)
                
                let details = band.formattedDetails()
                if details.count > 0 {
                    Text(band.formattedDetails())
                        .fontWeight(Font.Weight.thin)
                }
            }
        }
    }
}

struct BandView_Previews: PreviewProvider {
    static var previews: some View {
        BandView(band: BandRepository.sample.allBands.leatherLinks[0])
    }
}
