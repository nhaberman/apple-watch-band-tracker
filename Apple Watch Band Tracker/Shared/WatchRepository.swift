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
        
        do {
            try writeTestData()
        }
        catch {
            print("file write test unsuccessful")
        }
    }
}

struct AllWatchesSource: Decodable {
    var allWatches: [Watch]
}

func writeTestData() throws {
    
    let folderUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let fileUrl = folderUrl.appendingPathComponent("testname.txt")
    
    var dataToWrite = "Apple Watch Band Tracker\n\n"
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .full
    dateFormatter.timeStyle = .full
    dataToWrite += dateFormatter.string(from: date)
    
    try dataToWrite.write(toFile: fileUrl.path, atomically: false, encoding: String.Encoding.utf8)
    
}
