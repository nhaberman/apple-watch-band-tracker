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
        return lhs.model == rhs.model
            && lhs.series == rhs.series
            && lhs.material == rhs.material
            && lhs.finish == rhs.finish
            && lhs.edition == rhs.edition
            && lhs.size == rhs.size
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(model)
        hasher.combine(series)
        hasher.combine(material)
        hasher.combine(finish)
        hasher.combine(edition)
        hasher.combine(size)
    }
    
    var watchID: UUID
    var model: WatchModel
    var series: Int
    var material: WatchCaseMaterial
    var finish: WatchCaseFinish
    var edition: String?
    var size: Int = 0
    
    init(model: WatchModel, series: Int, material: WatchCaseMaterial, finish: WatchCaseFinish, size: Int, edition: String? = nil) {
        self.watchID = UUID()
        self.model = model
        self.series = series
        self.material = material
        self.finish = finish
        self.edition = edition
        self.size = size
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        watchID = try container.decode(UUID.self, forKey: .watchID)
        model = try container.decodeIfPresent(WatchModel.self, forKey: .model) ?? .series
        series = try container.decode(Int.self, forKey: .series)
        material = try container.decode(WatchCaseMaterial.self, forKey: .material)
        finish = try container.decode(WatchCaseFinish.self, forKey: .finish)
        edition = try container.decodeIfPresent(String.self, forKey: .edition)
        size = try container.decode(Int.self, forKey: .size)
    }
    
    // coding keys for watch properties
    enum CodingKeys: String, CodingKey {
        case watchID, model, series, material, finish, edition, size
    }
    
    func formattedName() -> String {
        "\(formattedModel())\n\(formattedColor())\n\(formattedSize())"
    }
    
    func formattedNameOneLine(useShortFormat: Bool = true) -> String {
        useShortFormat ?
            "\(formattedShortModel()) \(formattedShortColor()) - \(formattedSize())" :
            "\(formattedModel()), \(formattedColor()), \(formattedSize())"
    }
    
    func formattedModel() -> String {
        var result: String = ""
        
        switch model {
        case .none:
            break
        case .series:
            if (series == 0) {
                result = "1st Generation"
            }
            else {
                result = "\(model.rawValue) \(series)"
            }
        case .se, .ultra:
            result = "\(model.rawValue)"
            
            if (series > 1) {
                result += " \(series)"
            }
        }
        
        // edition
        if (edition != nil) {
            result += " (\(edition!))"
        }
        
        return result
    }
    
    func formattedShortModel() -> String {
        var result: String = ""
        
        switch model {
        case .none:
            break
        case .series:
            if (series == 0) {
                result = "1G"
            }
            else {
                result = "S\(series)"
            }
        case .se:
            result = "SE\(series)"
        case .ultra:
            result = "U\(series)"
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
            case .pink:
                return "Pink"
            case .starlight:
                return "SlA"
            case .midnight:
                return "MnA"
            case .jetBlack:
                return "JBA"
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
            case .natural:
                return "NT"
            case .gold:
                return "GT"
            case .slate:
                return "ST"
            case .black:
                return "BT"
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
        return "\(size) mm"
    }
    
    func getDisplayColor() -> Color {

        // There must be a color defined in Assets for each finish+material combination.
        // If not, no color or icon will be shown as this will return nothing.
        
        let colorName = (finish.rawValue.capitalized + material.rawValue.capitalized).replacingOccurrences(of: " ", with: "")
        return Color(colorName)
    }
}
