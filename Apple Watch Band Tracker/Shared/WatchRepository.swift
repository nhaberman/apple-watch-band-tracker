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
        allWatches = SampleWatches
        
        do {
            let allWatchesFilePath = Bundle.main.url(forResource: "AllWatches", withExtension: "json")
            
            let allWatchesFileContents = try String(contentsOf: allWatchesFilePath!)
            
//            let allBandsJson = try? JSONSerialization.json
            
        }
        catch {
            print("unsuccessful")
        }
        
    }
}
