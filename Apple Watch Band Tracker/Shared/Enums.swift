//
//  BandType.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import Foundation

public enum BandType: String, CaseIterable, Identifiable, Codable {
    
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
    case AlpineLoop = "Alpine Loop"
    case TrailLoop = "Trail Loop"
    case OceanBand = "Ocean Band"
    case ThirdPartyBand = "Third Party Band"
}

public enum Season: String, CaseIterable, Identifiable, Codable {
    
    public var id: Self { self }
    
    case spring = "Spring"
    case summer = "Summer"
    case fall = "Fall"
    case winter = "Winter"
}

public enum WatchCaseMaterial: String, Identifiable, Codable {
    public var id: Self { self }
    
    case none = "none"
    case aluminum = "Aluminum"
    case stainlessSteel = "Stainless Steel"
    case titanium = "Titanium"
    case ceramic = "Ceramic"
    case gold = "Gold"
}

public enum WatchCaseFinish: String, Identifiable, Codable {
    public var id: Self { self }
    
    case none = "none"
    case silver = "Silver"
    case spaceGray = "Space Gray"
    case gold = "Gold"
    case roseGold = "Rose Gold"
    case blue = "Blue"
    case red = "Red"
    case green = "Green"
    case starlight = "Starlight"
    case midnight = "Midnight"
    case spaceBlack = "Space Black"
    case graphite = "Graphite"
    case yellowGoldEdition = "Yellow"
    case roseGoldEdition = "Rose"
    case whiteCeramic = "White"
    case grayCeramic = "Gray"
}

public enum BandSortOrder: String, Identifiable, CaseIterable {
    public var id: Self { self }
    
    case date = "Date"
    case color = "Color"
    case logical = "Logical"
}
