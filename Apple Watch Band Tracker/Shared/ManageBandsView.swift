//
//  ManageBandsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/25/22.
//

import SwiftUI

struct ManageBandsView: View {
    
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
    
    var body: some View {
        List {
            ForEach(BandType.allCases) { bandType in
                let bands = bandRepository.getBandsByType(bandType)
                if bands.count > 0 {
                    Section(bandType.rawValue) {
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
                    }
                }
            }
        }
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
