//
//  WatchRepository.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/9/22.
//

import Foundation

class WatchRepository {
    var allWatches : [Watch]
    
    init() {
        self.allWatches = [Watch]()
        loadWatches()
    }
    
    func loadWatches() {
        do {
            let allWatchesFilePath = Bundle.main.url(forResource: "AllWatches", withExtension: "json")
            let allWatchesFileContents = try String(contentsOf: allWatchesFilePath!)
            let allWatchesJson = allWatchesFileContents.data(using: .utf8)!
            let allWatchesSource: AllWatchesSource = try! JSONDecoder().decode(AllWatchesSource.self, from: allWatchesJson)
            allWatches = allWatchesSource.allWatches
        }
        catch {
            print("unsuccessful")
            allWatches = SampleWatches
        }
    }
}

struct AllWatchesSource: Decodable {
    var allWatches: [Watch]
}
