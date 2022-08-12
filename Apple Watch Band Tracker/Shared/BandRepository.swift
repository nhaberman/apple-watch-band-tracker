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
        do {
            let allBandsFilePath = Bundle.main.url(forResource: "AllBands", withExtension: "json")
            let allBandsFileContents = try String(contentsOf: allBandsFilePath!)
            let allBandsJson = allBandsFileContents.data(using: .utf8)!
            let allBandsSource: AllBandsSource = try! JSONDecoder().decode(AllBandsSource.self, from: allBandsJson)
            allBands = allBandsSource.allBands
        }
        catch {
            print("unsuccessful")
            allBands = SampleBands
        }
    }
}

struct AllBandsSource: Decodable {
    var allBands: [Band]
}
