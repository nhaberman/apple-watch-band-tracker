//
//  Watch.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/7/22.
//

import Foundation
import SwiftUI

class Watch: Identifiable, Hashable {
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
    
    var series: Int
    var color: String
    var edition: String
    var size: Int
    
    init(series: Int, color: String, edition: String, size: Int) {
        self.series = series
        self.color = color
        self.edition = edition
        self.size = size
    }
    
    init(series: Int, color: String, size: Int) {
        self.series = series
        self.color = color
        self.edition = ""
        self.size = size
    }
    
    init() {
        self.series = 0
        self.color = "Gold"
        self.edition = "Edition"
        self.size = 42
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

struct WatchView : View {
    let watch: Watch
    
    var body: some View {
        HStack {
            Image(systemName: "applewatch")
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading) {
                Text(watch.formattedSeries())
                    .fontWeight(Font.Weight.bold)
                Text(watch.color)
                Text(watch.formattedSize())
            }
        }
    }
}

struct WatchView_Previews: PreviewProvider {
    static var previews: some View {
        WatchView(watch: Watch(
            series: 7,
            color: "Titanium",
            edition: "Edition",
            size: 45
        ))
    }
}
