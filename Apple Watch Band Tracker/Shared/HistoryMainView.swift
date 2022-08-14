//
//  HistoryMenuView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/8/22.
//

import SwiftUI

struct HistoryMainView: View {
    init(_ repository: BandHistoryRepository) {
        //Theme.navigationBarColors(background: .blue, titleColor: .white)
        self.repository = repository
    }
    
    let repository: BandHistoryRepository
    
    @State private var showTrackBandSheet = false
    @State private var showSettingsSheet = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Recent") {
                    NavigationLink {
                        HistoryView(repository: repository, lookBackDays: 1, pageTitle: "Recent")
                    } label: {
                        Label("Today", systemImage: "list.bullet")
                    }
                    NavigationLink {
                        HistoryView(repository: repository, lookBackDays: 7, pageTitle: "This Week")
                    } label: {
                        Label("This Week", systemImage: "list.bullet")
                    }
                    NavigationLink {
                        HistoryView(repository: repository, lookBackDays: 30, pageTitle: "This Month")
                    } label: {
                        Label("This Month", systemImage: "list.bullet")
                    }
                    NavigationLink {
                        HistoryView(repository: repository, lookBackDays: 365, pageTitle: "Year to Date")
                    } label: {
                        Label("Year to Date", systemImage: "list.bullet")
                    }
                }
                Section("By Year") {
                    NavigationLink {
                        HistoryView(repository: repository, lookBackDays: 2, pageTitle: "2022")
                    } label: {
                        Label("2022", systemImage: "calendar")
                    }
                    NavigationLink {
                        HistoryView(repository: repository, lookBackDays: 2, pageTitle: "2021")
                    } label: {
                        Label("2021", systemImage: "calendar")
                    }
                    NavigationLink {
                        HistoryView(repository: repository, lookBackDays: 2, pageTitle: "2020")
                    } label: {
                        Label("2020", systemImage: "calendar")
                    }
                }
                Section("All") {
                    NavigationLink {
                        HistoryView(repository: repository, lookBackDays: 2000, pageTitle: "All Bands")
                    } label: {
                        Label("All Bands", systemImage: "applewatch.side.right")
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("History")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("tapped settings")
                        showSettingsSheet = true
                    } label: {
                        Label("Settings", systemImage: "gear.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("tapped track band")
                        showTrackBandSheet = true
                    } label: {
                        Label("Track Band", systemImage: "plus.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $showTrackBandSheet, onDismiss: {
            print("goodbye track band sheet")
        }, content: {
            TrackBandView(repository)
        })
        .sheet(isPresented: $showSettingsSheet, onDismiss: {
            print("goodbye settings sheet")
        }, content: {
            SettingsView()
        })
    }
}

struct HistoryMainView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryMainView(BandHistoryRepository(false))
    }
}
