//
//  BandRepository.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/8/22.
//

import Foundation

class BandRepository {
    var allBands : [Band]
    
    init() {
        self.allBands = [Band]()
        loadBands()
    }
    
    func loadBands() {
        allBands = SampleBands
        
        do {
            let allBandsFilePath = Bundle.main.url(forResource: "AllBands", withExtension: "json")
            
            let allBandsFileContents = try String(contentsOf: allBandsFilePath!)
            
//            let allBandsJson = try? JSONSerialization.json
            
        }
        catch {
            print("unsuccessful")
        }
        
    }
}
