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
        
        Watch(series: 0, material: .aluminum, finish: .silver, size: 38),
        Watch(series: 0, material: .aluminum, finish: .spaceGray, size: 42),
        Watch(series: 1, material: .aluminum, finish: .roseGold, size: 38),
        Watch(series: 1, material: .aluminum, finish: .gold, size: 42),
        Watch(series: 0, material: .stainlessSteel, finish: .silver, size: 38),
        Watch(series: 0, material: .stainlessSteel, finish: .spaceBlack, size: 42),
        Watch(series: 0, material: .gold, finish: .yellowGoldEdition, size: 42, edition: "Gold Edition"),
        Watch(series: 0, material: .gold, finish: .roseGoldEdition, size: 38, edition: "Gold Edition"),
        Watch(series: 2, material: .ceramic, finish: .whiteCeramic, size: 42, edition: "Edition"),
        Watch(series: 3, material: .ceramic, finish: .grayCeramic, size: 42, edition: "Edition"),
        Watch(series: 4, material: .stainlessSteel, finish: .gold, size: 40),
        Watch(series: 5, material: .titanium, finish: .silver, size: 40, edition: "Edition"),
        Watch(series: 5, material: .titanium, finish: .spaceBlack, size: 44, edition: "Edition"),
        Watch(series: 6, material: .aluminum, finish: .blue, size: 44),
        Watch(series: 6, material: .aluminum, finish: .red, size: 40),
        Watch(series: 6, material: .stainlessSteel, finish: .graphite, size: 44),
        Watch(series: 7, material: .aluminum, finish: .green, size: 41),
        Watch(series: 7, material: .aluminum, finish: .midnight, size: 45),
        Watch(series: 7, material: .aluminum, finish: .starlight, size: 41, edition: "Nike"),
    ]
}

struct AllWatchesSource: Codable {
    var allWatches: [Watch]
}
