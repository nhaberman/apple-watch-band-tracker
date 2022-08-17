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
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40, alignment: .center)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(watch.getDisplayColor())
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            VStack(alignment: .leading) {
                Text(watch.formattedSeries())
                    .fontWeight(.bold)
                Text(watch.formattedColor())
                Text(watch.formattedSize())
                    .fontWeight(.light)
            }
        }
    }
}

struct WatchView_Previews: PreviewProvider {
    static var previews: some View {
        WatchView(watch: WatchRepository.sample.allWatches[0])
    }
}
