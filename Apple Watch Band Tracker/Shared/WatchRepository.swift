//
//  WatchRepository.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/9/22.
//

import Foundation

class WatchRepository {
    // sample repository
    static let sample = WatchRepository(false)
    
    var allWatches: [Watch]
    
    init(_ loadHistories: Bool = true) {
        self.allWatches = [Watch]()
        
        if loadHistories {
            loadWatches()
        }
        else {
            allWatches = sampleWatches
        }
    }
    
    private func loadWatches() {
        do {
            let allWatchesFilePath = Bundle.main.url(forResource: "AllWatches", withExtension: "json")
            let allWatchesFileContents = try String(contentsOf: allWatchesFilePath!)
            let allWatchesJson = allWatchesFileContents.data(using: .utf8)!
            let allWatchesSource: AllWatchesSource = try! JSONDecoder().decode(AllWatchesSource.self, from: allWatchesJson)
            allWatches = allWatchesSource.allWatches
        }
        catch {
            print("unsuccessful")
        }
    }
    
    private let sampleWatches = [
        Watch(series: 0, color: "Silver Stainless Steel", size: 42),
        Watch(series: 3, color: "Space Gray Aluminum", size: 42, edition: "Nike"),
        Watch(series: 5, color: "Gold Stainless Steel", size: 44),
        Watch(series: 5, color: "Space Black Stainless Steel", size: 44),
        Watch(series: 7, color: "Titanium", size: 45, edition: "Edition"),
    ]
}

struct AllWatchesSource: Decodable {
    var allWatches: [Watch]
}
