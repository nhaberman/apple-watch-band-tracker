//
//  ContentView.swift
//  Shared
//
//  Created by Nick Haberman on 8/5/22.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HistoryMainView()
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }.tag(1)
            BandsMainView()
                .tabItem {
                    Label("Bands", systemImage: "applewatch.side.right")
                }.tag(2)
            StatsMainView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.xaxis")
                }.tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainTabView()
        }
    }
}
