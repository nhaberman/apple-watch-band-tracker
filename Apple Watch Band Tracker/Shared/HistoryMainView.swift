//
//  HistoryMenuView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/8/22.
//

import SwiftUI

struct HistoryMainView: View {
//    init() {
//        Theme.navigationBarColors(background: .blue, titleColor: .white)
//    }
    
    // define the repositories that this view will use
    private var repository: BandHistoryRepository
    
    init(_ isPreview: Bool = false) {
        if isPreview {
            self.repository = BandHistoryRepository.sample
        }
        else {
            self.repository = BandHistoryRepository.default
        }
    }
    
    @State private var showTrackBandSheet = false
    @State private var showSettingsSheet = false
    
    var body: some View {
        NavigationView {
            List {
            Section("Recent") {
                NavigationLink {
                    HistoryView(pageTitle: "Recent", lookBackType: .currentDay)
                } label: {
                    Label("Today", systemImage: "list.bullet")
                }
                NavigationLink {
                    HistoryView(pageTitle: "This Week", lookBackType: .currentWeek)
                } label: {
                    Label("This Week", systemImage: "list.bullet")
                }
                NavigationLink {
                    HistoryView(pageTitle: "This Month", lookBackType: .currentMonth)
                } label: {
                    Label("This Month", systemImage: "list.bullet")
                }
                NavigationLink {
                    HistoryView(pageTitle: "Year to Date", lookBackType: .currentYear)
                } label: {
                    Label("Year to Date", systemImage: "list.bullet")
                }
            }
            Section("By Year") {
                ForEach(repository.getYearsWithHistory()) { bandYear in
                    NavigationLink {
                        HistoryView(pageTitle: String(bandYear.year), lookBackType: .specificYear, lookBackYear: bandYear.year)
                    } label: {
                        Label(String(bandYear.year), systemImage: "calendar")
                    }
                }
            }
            Section("All") {
                NavigationLink {
                    HistoryView(pageTitle: "All Bands", lookBackType: .all)
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
                        Label("Settings", systemImage: "gear.circle.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("tapped track band")
                        showTrackBandSheet = true
                    } label: {
                        Label("Track Band", systemImage: "plus.circle.fill")
                    }
                }
            }
            
            Label("Select a Timeframe", systemImage: "filemenu.and.selection")
        }
        .sheet(isPresented: $showSettingsSheet, onDismiss: {
            print("goodbye settings sheet")
        }, content: {
            SettingsView()
        })
        .sheet(isPresented: $showTrackBandSheet, onDismiss: {
            print("goodbye track band sheet")
        }, content: {
            TrackBandView()
        })
    }
}

struct HistoryMainView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryMainView(true)
    }
}
