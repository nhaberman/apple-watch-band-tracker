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
        Watch(series: 0, material: .stainlessSteel, finish: .silver, size: 42),
        Watch(series: 3, material: .aluminum, finish: .spaceGray, size: 42, edition: "Nike"),
        Watch(series: 5, material: .stainlessSteel, finish: .gold, size: 44),
        Watch(series: 5, material: .stainlessSteel, finish: .spaceBlack, size: 44),
        Watch(series: 7, material: .titanium, finish: .silver, size: 45, edition: "Edition"),
    ]
}

struct AllWatchesSource: Codable {
    var allWatches: [Watch]
}
