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
    
    var series: Int
    var material: WatchCaseMaterial
    var finish: WatchCaseFinish
    var edition: String?
    var size: Int = 0
    
    init(series: Int, material: WatchCaseMaterial, finish: WatchCaseFinish, size: Int, edition: String? = nil) {
        self.series = series
        self.material = material
        self.finish = finish
        self.edition = edition
        self.size = size
    }
    
    func formattedName() -> String {
        "\(formattedSeries())\n\(formattedColor())\n\(formattedSize())"
    }
    
    func formattedSeries() -> String {
        var result: String = ""
        
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
    
    func formattedSize() -> String {
        return "\(size)mm"
    }
    
    func getDisplayColor() -> Color {
        switch material {
        case .aluminum:
            switch finish {
            case .silver:
                return Color.accentColor
            case .spaceGray:
                return Color.gray
            case .gold:
                return Color("")
            case .roseGold:
                return Color.accentColor
            case .blue:
                return Color.accentColor
            case .red:
                return Color.accentColor
            case .green:
                return Color.accentColor
            case .starlight:
                return Color.accentColor
            case .midnight:
                return Color.accentColor
            default:
                return Color.accentColor
            }
        case .stainlessSteel:
            switch finish {
            case .silver:
                return Color.gray.opacity(0.5)
            case .gold:
                return Color.yellow
            case .spaceBlack:
                return Color.black
            case .graphite:
                return Color.accentColor
            default:
                return Color.accentColor
            }
        case .titanium:
            switch finish {
            case .silver:
                return Color.gray.opacity(0.75)
            case .spaceBlack:
                return Color.accentColor
            default:
                return Color.accentColor
            }
        case .ceramic:
            switch finish {
            case .whiteCeramic:
                return Color.accentColor
            case .grayCeramic:
                return Color.accentColor
            default:
                return Color.accentColor
            }
        case .gold:
            switch finish {
            case .yellowGoldEdition:
                return Color.accentColor
            case .roseGoldEdition:
                return Color.accentColor
            default:
                return Color.accentColor
            }
        default:
            return Color.accentColor
        }
    }
}
