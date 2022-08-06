//
//  ContentView.swift
//  Shared
//
//  Created by Nick Haberman on 8/5/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TrackBandView()
                .tabItem {
                    Label("Track", systemImage: "applewatch.side.right")
                }.tag(1)
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }.tag(2)
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.xaxis")
                }.tag(3)
            AllBandsView()
                .tabItem {
                    Label("All Bands", systemImage: "square.stack.3d.up")
                }.tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
