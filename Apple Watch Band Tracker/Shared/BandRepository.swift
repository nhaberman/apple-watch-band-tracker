//
//  BandRepository.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/8/22.
//

import Foundation
import SwiftUI

class BandRepository {
    // sample repository
    static let sample = BandRepository(false)
    
    var allBands: [Band]
    
    init(_ loadHistories: Bool = true) {
        self.allBands = [Band]()
        
        if loadHistories {
            loadBands()
        }
        else {
            self.allBands = sampleBands2
        }
    }
    
    private func loadBands() {
        do {
            let filePath = Bundle.main.url(forResource: "AllBands", withExtension: "json")
            let fileContents = try String(contentsOf: filePath!)
            let json = fileContents.data(using: .utf8)!
            let source = try! JSONDecoder().decode(AllBandsSource.self, from: json)
            
            allBands.append(contentsOf: source.sportBands)
            allBands.append(contentsOf: source.nikeSportBands)
            allBands.append(contentsOf: source.sportLoops)
            allBands.append(contentsOf: source.nikeSportLoops)
            allBands.append(contentsOf: source.soloLoops)
            allBands.append(contentsOf: source.braidedSoloLoops)
            allBands.append(contentsOf: source.wovenNylons)
            allBands.append(contentsOf: source.classicBuckles)
            allBands.append(contentsOf: source.modernBuckles)
            allBands.append(contentsOf: source.leatherLoops)
            allBands.append(contentsOf: source.leatherLinks)
            allBands.append(contentsOf: source.milaneseLoops)
            allBands.append(contentsOf: source.linkBracelets)
            allBands.append(contentsOf: source.thirdPartyBands)
        }
        catch {
            print("unsuccessful")
        }
    }
    
    func getBandsByType(_ bandType: BandType, sortOrder: BandSortOrder = .logical) -> [Band] {
        let results: [Band] = allBands.filter { band in
            band.bandType == bandType
        }
        
        switch sortOrder {
        case .date:
            return results.sorted(by: {$0.dateOrder ?? 0 > $1.dateOrder ?? 0})
        case .color:
            return results.sorted(by: {$0.colorOrder ?? 0 > $1.colorOrder ?? 0})
        case .logical:
            return results.sorted(by: {$0.logicalOrder ?? 0 > $1.logicalOrder ?? 0})
        }
    }
    
    private var sampleBands2: [Band] = [
        SportBand(color: "Capri Blue", season: .spring, year: 2021),
        NikeSportBand(color: "Obsidian / Black", season: .summer, year: 2017),
        SportLoop(color: "Red", season: .fall, year: 2018, bandVersion: .fleck, generation: 1),
        NikeSportLoop(color: "Purple Pulse", season: .fall, year: 2020, bandVersion: .reflective),
        SoloLoop(color: "Plum", season: .winter, year: 2020, bandSize: 6),
        BraidedSoloLoop(color: "Charcoal", season: .fall, year: 2020, bandSize: 5),
        WovenNylon(color: "Pearl", season: .spring, year: 2016, bandVersion: .original),
        ClassicBuckle(color: "Saddle Brown", season: .spring, year: 2016, generation: 3),
        ModernBuckle(color: "Black", season: .spring, year: 2015, bandSize: .large, generation: 1),
        LeatherLoop(color: "Bright Blue", season: .spring, year: 2015, bandSize: .large),
        LeatherLink(color: "Dark Cherry", season: .fall, year: 2021, bandSize: .smallMedium),
        MilaneseLoop(color: "Silver", season: .spring, year: 2015),
        LinkBracelet(color: "Space Black", season: .fall, year: 2021),
        ThirdPartyBand(color: "Modern Strap Rustic Brown", manufacturer: "Nomad")
    ]
}

struct AllBandsSource: Codable {
    var sportBands : [SportBand] = [SportBand]()
    var nikeSportBands : [NikeSportBand] = [NikeSportBand]()
    var sportLoops : [SportLoop] = [SportLoop]()
    var nikeSportLoops : [NikeSportLoop] = [NikeSportLoop]()
    var soloLoops : [SoloLoop] = [SoloLoop]()
    var braidedSoloLoops : [BraidedSoloLoop] = [BraidedSoloLoop]()
    var wovenNylons : [WovenNylon] = [WovenNylon]()
    var classicBuckles : [ClassicBuckle] = [ClassicBuckle]()
    var modernBuckles : [ModernBuckle] = [ModernBuckle]()
    var leatherLoops : [LeatherLoop] = [LeatherLoop]()
    var leatherLinks : [LeatherLink] = [LeatherLink]()
    var milaneseLoops : [MilaneseLoop] = [MilaneseLoop]()
    var linkBracelets : [LinkBracelet] = [LinkBracelet]()
    var thirdPartyBands : [ThirdPartyBand] = [ThirdPartyBand]()
}
