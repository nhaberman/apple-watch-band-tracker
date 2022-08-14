//
//  BandType.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import Foundation

public enum BandType: String, CaseIterable, Identifiable, Decodable, Encodable {
    
    public var id: Self { self }
    
    case None = "None"
    case SportBand = "Sport Band"
    case NikeSportBand = "Nike Sport Band"
    case SportLoop = "Sport Loop"
    case NikeSportLoop = "Nike Sport Loop"
    case SoloLoop = "Solo Loop"
    case BraidedSoloLoop = "Braided Solo Loop"
    case WovenNylon = "Woven Nylon"
    case ClassicBuckle = "Classic Buckle"
    case ModernBuckle = "Modern Buckle"
    case LeatherLoop = "Leather Loop"
    case LeatherLink = "Leather Link"
    case MilaneseLoop = "Milanese Loop"
    case LinkBracelet = "Link Bracelet"
    case ThirdPartyBand = "Third Party Band"
}

public enum Season: String, CaseIterable, Identifiable, Decodable, Encodable {
    
    public var id: Self { self }
    
    case spring = "Spring"
    case summer = "Summer"
    case fall = "Fall"
    case winter = "Winter"
}
