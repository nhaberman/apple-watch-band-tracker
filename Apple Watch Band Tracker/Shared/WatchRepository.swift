//
//  WatchRepository.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/9/22.
//

import Foundation

class WatchRepository {
    // static repositories
    static let sample = WatchRepository(false)
    static let `default` = WatchRepository()
    
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
    
    func saveWatches() -> Bool {
        do {
            let source = AllWatchesSource(allWatches: allWatches)
            let fileManager = FileManager.default
            let outputFileName = "AllWatches"
            let outputFolderUrl = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let outputFileUrl = outputFolderUrl.appendingPathComponent(outputFileName)
            
            // save watches to JSON file
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = [.sortedKeys, .prettyPrinted]
            let jsonData = try jsonEncoder.encode(source)
            let jsonString = String(data: jsonData, encoding: .utf8)
            try jsonString?.write(to: outputFileUrl.appendingPathExtension("json"), atomically: false, encoding: .utf8)
            
            return true
        }
        catch {
            print("unsuccessful")
            return false
        }
    }
    
    func getWatchByID(_ watchID: UUID) -> Watch? {
        return allWatches.first { watch in
            watch.watchID == watchID
        }
    }
    
    private let sampleWatches = [
        
        
        Watch(model: .series, series: 0, material: .aluminum, finish: .silver, size: 38),
        Watch(model: .series, series: 0, material: .aluminum, finish: .spaceGray, size: 42),
        Watch(model: .series, series: 0, material: .stainlessSteel, finish: .spaceBlack, size: 38),
        Watch(model: .series, series: 0, material: .stainlessSteel, finish: .silver, size: 42),
        Watch(model: .series, series: 0, material: .gold, finish: .yellowGoldEdition, size: 42, edition: "Gold Edition"),
        Watch(model: .series, series: 0, material: .gold, finish: .roseGoldEdition, size: 38, edition: "Gold Edition"),
        Watch(model: .series, series: 0, material: .stainlessSteel, finish: .silver, size: 42, edition: "Hermes"),
        Watch(model: .series, series: 1, material: .aluminum, finish: .roseGold, size: 38),
        Watch(model: .series, series: 1, material: .aluminum, finish: .gold, size: 42),
        Watch(model: .series, series: 2, material: .ceramic, finish: .whiteCeramic, size: 42, edition: "Edition"),
        Watch(model: .series, series: 3, material: .aluminum, finish: .spaceGray, size: 42, edition: "Nike"),
        Watch(model: .series, series: 3, material: .ceramic, finish: .grayCeramic, size: 42, edition: "Edition"),
        Watch(model: .series, series: 4, material: .stainlessSteel, finish: .gold, size: 40),
        Watch(model: .series, series: 5, material: .stainlessSteel, finish: .gold, size: 44),
        Watch(model: .series, series: 5, material: .stainlessSteel, finish: .spaceBlack, size: 44),
        Watch(model: .series, series: 5, material: .titanium, finish: .silver, size: 40, edition: "Edition"),
        Watch(model: .series, series: 5, material: .titanium, finish: .spaceBlack, size: 44, edition: "Edition"),
        Watch(model: .series, series: 5, material: .ceramic, finish: .whiteCeramic, size: 44, edition: "Edition"),
        Watch(model: .se, series: 1, material: .aluminum, finish: .silver, size: 40),
        Watch(model: .se, series: 1, material: .aluminum, finish: .spaceGray, size: 44),
        Watch(model: .se, series: 1, material: .aluminum, finish: .gold, size: 44),
        Watch(model: .series, series: 6, material: .aluminum, finish: .red, size: 40),
        Watch(model: .series, series: 6, material: .aluminum, finish: .blue, size: 44),
        Watch(model: .series, series: 6, material: .stainlessSteel, finish: .graphite, size: 44),
        Watch(model: .series, series: 6, material: .stainlessSteel, finish: .spaceBlack, size: 44, edition: "Hermes"),
        Watch(model: .series, series: 7, material: .aluminum, finish: .green, size: 41),
        Watch(model: .series, series: 7, material: .aluminum, finish: .starlight, size: 41),
        Watch(model: .series, series: 7, material: .aluminum, finish: .midnight, size: 45),
        Watch(model: .series, series: 7, material: .aluminum, finish: .starlight, size: 41, edition: "Nike"),
        Watch(model: .series, series: 7, material: .aluminum, finish: .midnight, size: 45, edition: "Nike"),
        Watch(model: .series, series: 7, material: .titanium, finish: .silver, size: 45, edition: "Edition"),
        Watch(model: .se, series: 2, material: .aluminum, finish: .silver, size: 44),
        Watch(model: .se, series: 2, material: .aluminum, finish: .starlight, size: 44),
        Watch(model: .se, series: 2, material: .aluminum, finish: .midnight, size: 40),
        Watch(model: .series, series: 8, material: .aluminum, finish: .silver, size: 41),
        Watch(model: .series, series: 8, material: .stainlessSteel, finish: .gold, size: 45),
        Watch(model: .ultra, series: 1, material: .titanium, finish: .natural, size: 49),
        Watch(model: .series, series: 9, material: .aluminum, finish: .pink, size: 41),
        Watch(model: .series, series: 9, material: .aluminum, finish: .midnight, size: 45),
        Watch(model: .series, series: 9, material: .stainlessSteel, finish: .silver, size: 45),
        Watch(model: .ultra, series: 2, material: .titanium, finish: .natural, size: 49),
        Watch(model: .series, series: 10, material: .aluminum, finish: .silver, size: 42),
        Watch(model: .series, series: 10, material: .aluminum, finish: .roseGold, size: 42),
        Watch(model: .series, series: 10, material: .aluminum, finish: .jetBlack, size: 46),
        Watch(model: .series, series: 10, material: .titanium, finish: .natural, size: 46),
        Watch(model: .series, series: 10, material: .titanium, finish: .gold, size: 42),
        Watch(model: .series, series: 10, material: .titanium, finish: .slate, size: 46),
        Watch(model: .series, series: 10, material: .titanium, finish: .silver, size: 46, edition: "Hermes"),
        Watch(model: .ultra, series: 2, material: .titanium, finish: .black, size: 49),
        Watch(model: .ultra, series: 2, material: .titanium, finish: .natural, size: 49, edition: "Hermes"),
        Watch(model: .se, series: 3, material: .aluminum, finish: .starlight, size: 40),
        Watch(model: .se, series: 3, material: .aluminum, finish: .midnight, size: 44),
        Watch(model: .series, series: 11, material: .aluminum, finish: .jetBlack, size: 42),
        Watch(model: .series, series: 11, material: .stainlessSteel, finish: .gold, size: 46),
        Watch(model: .ultra, series: 3, material: .titanium, finish: .natural, size: 49),
        Watch(model: .ultra, series: 3, material: .titanium, finish: .black, size: 49),
    ]
}

struct AllWatchesSource: Codable {
    var allWatches: [Watch]
}
