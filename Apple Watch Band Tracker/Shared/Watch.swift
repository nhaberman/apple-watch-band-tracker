//
//  Watch.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/7/22.
//

import Foundation
import SwiftUI

class Watch: Identifiable, Hashable, Codable {
    static func == (lhs: Watch, rhs: Watch) -> Bool {
        return lhs.series == rhs.series
            && lhs.material == rhs.material
            && lhs.finish == rhs.finish
            && lhs.edition == rhs.edition
            && lhs.size == rhs.size
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(series)
        hasher.combine(material)
        hasher.combine(finish)
        hasher.combine(edition)
        hasher.combine(size)
    }
    
    var watchID: UUID
    var series: Int
    var model: String?
    var material: WatchCaseMaterial
    var finish: WatchCaseFinish
    var edition: String?
    var size: Int = 0
    
    init(series: Int, material: WatchCaseMaterial, finish: WatchCaseFinish, size: Int, edition: String? = nil) {
        self.watchID = UUID()
        self.series = series
        self.material = material
        self.finish = finish
        self.edition = edition
        self.size = size
    }
    
    func formattedName() -> String {
        "\(formattedSeries())\n\(formattedColor())\n\(formattedSize())"
    }
    
    func formattedNameOneLine() -> String {
        "\(formattedShortSeries()) \(formattedShortColor()) - \(formattedSize())"
    }
    
    func formattedSeries() -> String {
        var result: String = ""
        
        if (model != nil) {
            result = model!
        }
        else {
            if (series == 0) {
                result = "1st Generation"
            }
            else {
                result = "Series \(series)"
            }
            
            // edition
            if (edition != nil) {
                result += " (\(edition!))"
            }
        }
        
        return result
    }
    
    func formattedShortSeries() -> String {
        var result: String = ""
        
        if (series == 0) {
            result = "1G"
        }
        else {
            result = "S\(series)"
        }
        
        // edition
        if (edition != nil) {
            result += " (\(edition!))"
        }
        
        return result
    }
    
    func formattedColor() -> String {
        if (material == .stainlessSteel || material == .titanium) && finish == .silver {
            return material.rawValue
        }
        else {
            return finish.rawValue + " " + material.rawValue
        }
    }
    
    func formattedShortColor() -> String {
        switch material {
        case .aluminum:
            switch finish {
            case .silver:
                return "SA"
            case .spaceGray:
                return "SGA"
            case .gold:
                return "GA"
            case .roseGold:
                return "RGA"
            case .blue:
                return "Blue"
            case .red:
                return "Red"
            case .green:
                return "Green"
            case .starlight:
                return "SlA"
            case .midnight:
                return "MnA"
            default:
                return ""
            }
        case .stainlessSteel:
            switch finish {
            case .silver:
                return "SS"
            case .gold:
                return "GSS"
            case .spaceBlack:
                return "SBSS"
            case .graphite:
                return "GrSS"
            default:
                return ""
            }
        case .titanium:
            switch finish {
            case .silver:
                return "Ti"
            case .spaceBlack:
                return "SB Ti"
            default:
                return ""
            }
        case .ceramic:
            switch finish {
            case .whiteCeramic:
                return "C (E)"
            case .grayCeramic:
                return "GC (E)"
            default:
                return ""
            }
        case .gold:
            switch finish {
            case .yellowGoldEdition:
                return "YG (E)"
            case .roseGoldEdition:
                return "RG (E)"
            default:
                return ""
            }
        default:
            return ""
        }
    }
    
    func formattedSize() -> String {
        return "\(size)mm"
    }
    
    func getDisplayColor() -> Color {
        let colorName = (finish.rawValue.capitalized + material.rawValue.capitalized).replacingOccurrences(of: " ", with: "")
        return Color(colorName)
    }
}
