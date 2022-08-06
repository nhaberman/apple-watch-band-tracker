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
            TrackBandTabView()
                .tabItem {
                    Label("Track", systemImage: "applewatch.side.right")
                }.tag(1)
            HistoryTabView()
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }.tag(2)
            StatsTabView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.xaxis")
                }.tag(3)
            AllBandsTabView()
                .tabItem {
                    Label("All Bands", systemImage: "square.stack.3d.up")
                }.tag(4)
        }
        .padding()

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct TrackBandTabView: View {
    var body: some View {
        NavigationView {
            VStack(
                alignment: .leading
            ) {
                GroupBox(
                    label: Text("Select Apple Watch")) {
                    List {
                        Text("test1")
                        Text("test1")
                        Text("test1")
                    }
                }
                
                GroupBox(
                    label: Text("Select Band Type")) {
                    List {
                        Text("test1")
                        Text("test1")
                        Text("test1")
                    }
                }
                Text("Select Band Type")
                    .padding()
                
                Text("Select Band Color")
                    .padding()
                
                Text("Select Time")
                    .padding()
                
                Text("Button to save")
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationTitle("Track Band")
        }
    }
}

struct HistoryTabView: View {
    var body: some View {
        VStack {
            Text("Hello, world! (2)")
                .padding()
            (Button("Button") {
                print("test")
            }).padding()
            Button("Test Button Again",
                   action: TestAction)
            .padding()
        }.buttonStyle(.bordered)
    }
}

struct StatsTabView: View {
    var body: some View {
        VStack {
            Text("Hello, world! (3)")
                .padding()
            (Button("Button") {
                print("test")
            }).padding()
            Button("Test Button Again",
                   action: TestAction)
            .padding()
        }.buttonStyle(.bordered)
    }
}

struct AllBandsTabView: View {
    var body: some View {
        VStack {
            Text("Hello, world! (4)")
                .padding()
            (Button("Button") {
                print("test")
            }).padding()
            Button("Test Button Again",
                   action: TestAction)
            .padding()
        }.buttonStyle(.bordered)
    }
}

func TestAction() {
    // Do whatever you need when the button is pressed
    print("Hello World test?")
}
