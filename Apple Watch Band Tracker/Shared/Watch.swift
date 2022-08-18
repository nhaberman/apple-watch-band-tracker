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
        let colorName = (finish.rawValue.capitalized + material.rawValue.capitalized).replacingOccurrences(of: " ", with: "")
        return Color(colorName)
    }
}
