//
//  WatchView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/12/22.
//

import SwiftUI

struct WatchView : View {
    let watch: Watch
    
    var body: some View {
        HStack {
            Image(systemName: "applewatch")
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading) {
                Text(watch.formattedSeries())
                    .fontWeight(Font.Weight.bold)
                Text(watch.color)
                Text(watch.formattedSize())
            }
        }
    }
}

struct WatchView_Previews: PreviewProvider {
    static var previews: some View {
        WatchView(watch: Watch(
            series: 7,
            color: "Titanium",
            size: 45,
            edition: "Edition"
        ))
    }
}
