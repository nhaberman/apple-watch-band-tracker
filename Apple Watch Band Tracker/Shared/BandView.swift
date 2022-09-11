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
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40, alignment: .center)
                    .symbolRenderingMode(.hierarchical)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            }
            VStack(alignment: .leading) {
                if showBandType {
                    Text(band.bandType.rawValue)
                        .font(.headline)
                }
                
                if band.bandType == .ThirdPartyBand {
                    Text(band.formattedName())
                }
                else {
                    Text(band.color)
                }
                
                let details = band.formattedDetails()
                if details.count > 0 {
                    Text(band.formattedDetails())
                        .font(.caption)
                }
            }
        }
    }
}

struct BandView_Previews: PreviewProvider {
    static var previews: some View {
        BandView(band: BandRepository.sample.allBands[0], showBandType: true, showIcon: true)
    }
}
