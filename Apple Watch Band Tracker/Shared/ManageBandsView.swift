//
//  ManageBandsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/25/22.
//

import SwiftUI

struct ManageBandsView: View {
    @State var showingDefaultSection = true
    @State var showingSportBandSection = false
    @State var showingNikeSportBandSection = false
    @State var showingSportLoopSection = false
    @State var showingNikeSportLoopSection = false
    @State var showingSoloLoopSection = false
    @State var showingBraidedSoloLoopSection = false
    @State var showingWovenNylonSection = false
    @State var showingClassicBuckleSection = false
    @State var showingModernBuckleSection = false
    @State var showingLeatherLoopSection = false
    @State var showingLeatherLinkSection = false
    @State var showingMagneticLinkSection = false
    @State var showingMilaneseLoopSection = false
    @State var showingLinkBraceletSection = false
    @State var showingAlpineLoopSection = false
    @State var showingTrailLoopSection = false
    @State var showingOceanBandSection = false
    @State var showingTitaniumMilaneseLoopSection = false
    @State var showingThirdPartyBandSection = false
    
    private var bandRepository: BandRepository
    private var manageType: ManageType
    
    init() {
        self.bandRepository = BandRepository.sample
        self.manageType = .owned
        
        self.allBands = bandRepository.allBands
    }
    
    init(_ manageType: ManageType) {
        self.bandRepository = BandRepository.default
        self.manageType = manageType
        
        self.allBands = bandRepository.allBands
    }
    
    @State var allBands: [Band]
    
    func GetStateValue(bandType: BandType) -> Binding<Bool> {
        
        switch bandType {
        case .SportBand:
            return $showingSportBandSection
        case .NikeSportBand:
            return $showingNikeSportBandSection
        case .SportLoop:
            return $showingSportLoopSection
        case .NikeSportLoop:
            return $showingNikeSportLoopSection
        case .SoloLoop:
            return $showingSoloLoopSection
        case .BraidedSoloLoop:
            return $showingBraidedSoloLoopSection
        case .WovenNylon:
            return $showingWovenNylonSection
        case .ClassicBuckle:
            return $showingClassicBuckleSection
        case .ModernBuckle:
            return $showingModernBuckleSection
        case .LeatherLoop:
            return $showingLeatherLoopSection
        case .LeatherLink:
            return $showingLeatherLinkSection
        case .MagneticLink:
            return $showingMagneticLinkSection
        case .MilaneseLoop:
            return $showingMagneticLinkSection
        case .LinkBracelet:
            return $showingLinkBraceletSection
        case .AlpineLoop:
            return $showingAlpineLoopSection
        case .TrailLoop:
            return $showingTrailLoopSection
        case .OceanBand:
            return $showingOceanBandSection
        case .TitaniumMilaneseLoop:
            return $showingTitaniumMilaneseLoopSection
        case .ThirdPartyBand:
            return $showingThirdPartyBandSection
        default:
            return $showingDefaultSection
        }
    }
    
    var body: some View {
        List {
            ForEach(BandType.allCases) { bandType in
                let bands = bandRepository.getBandsByType(bandType)
                if bands.count > 0 {
                    Section(isExpanded: GetStateValue(bandType: bandType)) {
                        ForEach(bands) { band in
                            let index = allBands.firstIndex(of: band)
                                
                            if index != nil {
                                switch manageType {
                                case .owned:
                                    Toggle(band.formattedName(), isOn: $allBands[index!].isOwned)
                                case .favorite:
                                    Toggle(band.formattedName(), isOn: $allBands[index!].isFavorite)
                                }
                            }
                        }
                    } header: {
                        Text(bandType.rawValue)
                    }
                }
            }
        }
        .listStyle(.sidebar)
        .onDisappear {
            switch manageType {
            case .owned:
                bandRepository.saveOwnedBands()
            case .favorite:
                bandRepository.saveFavoriteBands()
            }
        }
    }
    
    enum ManageType: String {
        case owned = "Owned"
        case favorite = "Favorite"
    }
}

struct ManageBandsView_Previews: PreviewProvider {
    static var previews: some View {
        ManageBandsView()
    }
}
