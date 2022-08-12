//
//  BandView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/12/22.
//

import SwiftUI

struct BandView : View {
    let band: Band
    
    var body: some View {
        HStack{
            //Image(systemName: "applewatch.side.right")
                //.aspectRatio(contentMode: .fill)
            VStack(alignment: .leading) {
                Text(band.bandType.rawValue)
                    .fontWeight(Font.Weight.bold)
                Text(band.formattedColorName())
            }
        }
    }
}

struct BandView_Previews: PreviewProvider {
    static var previews: some View {
        BandView(band: LeatherLink(
            color: "Saddle Brown",
            season: Season.fall,
            year: 2022,
            bandSize: .smallMedium))
    }
}
