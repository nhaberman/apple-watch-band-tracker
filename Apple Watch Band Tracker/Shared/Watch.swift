//
//  Watch.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/7/22.
//

import Foundation
import SwiftUI

class Watch: Identifiable, Hashable, Decodable {
    static func == (lhs: Watch, rhs: Watch) -> Bool {
        return lhs.series == rhs.series
            && lhs.color == rhs.color
            && lhs.edition == rhs.edition
            && lhs.size == rhs.size
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(series)
        hasher.combine(color)
        hasher.combine(edition)
        hasher.combine(size)
    }
    
    var series: Int = 0
    var color: String = ""
    var edition: String = ""
    var size: Int = 0
    
    init(series: Int, color: String, size: Int, edition: String = "") {
        self.series = series
        self.color = color
        self.edition = edition
        self.size = size
    }
    
    func formattedName() -> String {
        var result: String = ""
        
        // series line
        result += formattedSeries()
        
        // color line
        result += "\n\(color)\n"
        
        // size line
        result += formattedSize()
        
        return result
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
        if (edition != "") {
            result += " (\(edition))"
        }
        
        return result
    }
    
    func formattedSize() -> String {
        return "\(size)mm"
    }
}

