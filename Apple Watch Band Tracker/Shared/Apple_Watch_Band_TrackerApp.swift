//
//  Apple_Watch_Band_TrackerApp.swift
//  Shared
//
//  Created by Nick Haberman on 8/5/22.
//

import SwiftUI

@main
struct Apple_Watch_Band_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}

// define the repositories here that will be used throughout the app
let GlobalBandRepository = BandRepository()
let GlobalBandHistoryRepository = BandHistoryRepository()
let GlobalWatchRepository = WatchRepository()
