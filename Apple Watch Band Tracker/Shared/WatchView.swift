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
        //.background(getBackgroundColor())
    }
    
    func getBackgroundColor() -> Color {
        switch (watch.color) {
        case "Silver Stainless Steel":
            return Color.gray
        case "Space Gray Aluminum":
            return Color.red
        case "Gold Stainless Steel":
            return Color.green
        case "Space Black Stainless Steel":
            return Color.blue
        case "Titanium":
            return Color.orange
            
        default:
            return Color.white
        }
    }
}

struct WatchView_Previews: PreviewProvider {
    static var previews: some View {
        WatchView(watch: WatchRepository.sample.allWatches[0])
    }
}
