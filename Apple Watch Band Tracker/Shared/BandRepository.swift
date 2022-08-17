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
    
    var allBands: AllBandsSource
    
    init(_ loadHistories: Bool = true) {
        self.allBands = AllBandsSource()
        
        if loadHistories {
            loadBands()
        }
        else {
            self.allBands = sampleBands
        }
    }
    
    private func loadBands() {
        do {
            let filePath = Bundle.main.url(forResource: "AllBands", withExtension: "json")
            let fileContents = try String(contentsOf: filePath!)
            let json = fileContents.data(using: .utf8)!
            allBands = try! JSONDecoder().decode(AllBandsSource.self, from: json)
        }
        catch {
            print("unsuccessful")
        }
    }
    
    func getBandsByType(_ bandType: BandType, sortOrder: BandSortOrder = .logical) -> [Band] {
        var results: [Band]
        
        switch(bandType) {
        case .SportBand:
            results = allBands.sportBands
        case .NikeSportBand:
            results = allBands.nikeSportBands
        case .SportLoop:
            results = allBands.sportLoops
        case .NikeSportLoop:
            results = allBands.nikeSportLoops
        case .SoloLoop:
            results = allBands.soloLoops
        case .BraidedSoloLoop:
            results = allBands.braidedSoloLoops
        case .WovenNylon:
            results = allBands.wovenNylons
        case .ClassicBuckle:
            results = allBands.classicBuckles
        case .ModernBuckle:
            results = allBands.modernBuckles
        case .LeatherLoop:
            results = allBands.leatherLoops
        case .LeatherLink:
            results = allBands.leatherLinks
        case .MilaneseLoop:
            results = allBands.milaneseLoops
        case .LinkBracelet:
            results = allBands.linkBracelets
        case .ThirdPartyBand:
            results = allBands.thirdPartyBands
        default:
            results = [Band]()
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
    
    private var sampleBands: AllBandsSource {
        var source = AllBandsSource()
        source.sportBands.append(SportBand(
            color: "Capri Blue",
            season: .spring,
            year: 2021))
        source.nikeSportBands.append(NikeSportBand(
            color: "Obsidian / Black",
            season: .summer,
            year: 2017))
        source.sportLoops.append(SportLoop(
            color: "Red",
            season: .fall,
            year: 2018,
            bandVersion: .fleck,
            generation: 1))
        source.nikeSportLoops.append(NikeSportLoop(
            color: "Purple Pulse",
            season: .fall,
            year: 2020,
            bandVersion: .reflective))
        source.soloLoops.append(SoloLoop(
            color: "Plum",
            season: .winter,
            year: 2020,
            bandSize: 6))
        source.braidedSoloLoops.append(BraidedSoloLoop(
            color: "Charcoal",
            season: .fall,
            year: 2020,
            bandSize: 5))
        source.wovenNylons.append(WovenNylon(
            color: "Pearl",
            season: .spring,
            year: 2016,
            bandVersion: .original))
        source.classicBuckles.append(ClassicBuckle(
            color: "Saddle Brown",
            season: .spring,
            year: 2016,
            generation: 3))
        source.modernBuckles.append(ModernBuckle(
            color: "Black",
            season: .spring,
            year: 2015,
            bandSize: .large,
            generation: 1))
        source.leatherLoops.append(LeatherLoop(
            color: "Bright Blue",
            season: .spring,
            year: 2015,
            bandSize: .large))
        source.leatherLinks.append(LeatherLink(
            color: "Dark Cherry",
            season: .fall,
            year: 2021,
            bandSize: .smallMedium))
        source.milaneseLoops.append(MilaneseLoop(
            color: "Silver",
            season: .spring,
            year: 2015))
        source.linkBracelets.append(LinkBracelet(
            color: "Space Black",
            season: .fall,
            year: 2021))
        source.thirdPartyBands.append(ThirdPartyBand(
            color: "Modern Strap Rustic Brown",
            manufacturer: "Nomad"))
        
        return source
    }
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
