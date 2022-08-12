//
//  BandRepository.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/8/22.
//

import Foundation

class BandRepository {
    var sportBands : [SportBand]
    var nikeSportBands : [NikeSportBand]
    var sportLoops : [SportLoop]
    var nikeSportLoops : [NikeSportLoop]
    var soloLoops : [SoloLoop]
    var braidedSoloLoops : [BraidedSoloLoop]
    var wovenNylons : [WovenNylon]
    var classicBuckles : [ClassicBuckle]
    var modernBuckles : [ModernBuckle]
    var leatherLoops : [LeatherLoop]
    var leatherLinks : [LeatherLink]
    var milaneseLoops : [MilaneseLoop]
    var linkBracelets : [LinkBracelet]
    var thirdPartyBands : [ThirdPartyBand]
    
    
    init() {
        sportBands = [SportBand]()
        nikeSportBands = [NikeSportBand]()
        sportLoops = [SportLoop]()
        nikeSportLoops = [NikeSportLoop]()
        soloLoops = [SoloLoop]()
        braidedSoloLoops = [BraidedSoloLoop]()
        wovenNylons = [WovenNylon]()
        classicBuckles = [ClassicBuckle]()
        modernBuckles = [ModernBuckle]()
        leatherLoops = [LeatherLoop]()
        leatherLinks = [LeatherLink]()
        milaneseLoops = [MilaneseLoop]()
        linkBracelets = [LinkBracelet]()
        thirdPartyBands = [ThirdPartyBand]()
        
        loadBands()
    }
    
    func loadBands() {
        do {
            let filePath = Bundle.main.url(forResource: "AllBands", withExtension: "json")
            let fileContents = try String(contentsOf: filePath!)
            let json = fileContents.data(using: .utf8)!
            let source: AllBandsSource = try! JSONDecoder().decode(AllBandsSource.self, from: json)
            
            sportBands = source.sportBands
            nikeSportBands = source.nikeSportBands
            sportLoops = source.sportLoops
            nikeSportLoops = source.nikeSportLoops
            soloLoops = source.soloLoops
            braidedSoloLoops = source.braidedSoloLoops
            wovenNylons = source.wovenNylons
            classicBuckles = source.classicBuckles
            modernBuckles = source.modernBuckles
            leatherLoops = source.leatherLoops
            leatherLinks = source.leatherLinks
            milaneseLoops = source.milaneseLoops
            linkBracelets = source.linkBracelets
            thirdPartyBands = source.thirdPartyBands
        }
        catch {
            print("unsuccessful")
        }
    }
    
    func getBandsByType(_ bandType: BandType) -> [Band] {
        switch(bandType) {
        case .SportBand:
            return sportBands
        case .NikeSportBand:
            return nikeSportBands
        case .SportLoop:
            return sportLoops
        case .NikeSportLoop:
            return nikeSportLoops
        case .SoloLoop:
            return soloLoops
        case .BraidedSoloLoop:
            return braidedSoloLoops
        case .WovenNylon:
            return wovenNylons
        case .ClassicBuckle:
            return classicBuckles
        case .ModernBuckle:
            return modernBuckles
        case .LeatherLoop:
            return leatherLoops
        case .LeatherLink:
            return leatherLinks
        case .MilaneseLoop:
            return milaneseLoops
        case .LinkBracelet:
            return linkBracelets
        case .ThirdPartyBand:
            return thirdPartyBands
        default:
            return [Band]()
        }
    }
}

struct AllBandsSource: Decodable {
    var sportBands : [SportBand]
    var nikeSportBands : [NikeSportBand]
    var sportLoops : [SportLoop]
    var nikeSportLoops : [NikeSportLoop]
    var soloLoops : [SoloLoop]
    var braidedSoloLoops : [BraidedSoloLoop]
    var wovenNylons : [WovenNylon]
    var classicBuckles : [ClassicBuckle]
    var modernBuckles : [ModernBuckle]
    var leatherLoops : [LeatherLoop]
    var leatherLinks : [LeatherLink]
    var milaneseLoops : [MilaneseLoop]
    var linkBracelets : [LinkBracelet]
    var thirdPartyBands : [ThirdPartyBand]
}
