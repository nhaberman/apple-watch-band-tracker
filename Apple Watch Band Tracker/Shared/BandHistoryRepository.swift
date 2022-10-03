//
//  BandHistoryRepository.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/8/22.
//

import Foundation
import SwiftUI

class BandHistoryRepository {
    // static repositories
    static let sample = BandHistoryRepository(false)
    static let `default` = BandHistoryRepository()
    
    var bandHistories: [BandHistory]
    var groupedHistories: [HistoryDate]
    
    init(_ loadHistories: Bool = true) {
        self.bandHistories = [BandHistory]()
        self.groupedHistories = [HistoryDate]()
        
        if loadHistories {
            loadHistory()
        }
        else {
            bandHistories = sampleBandHistories
        }
        
        self.groupedHistories = getHistoriesGroupedByDate()
    }
    
    func trackBand(bandHistory: BandHistory) -> Bool {
        // add the band to the band history
        bandHistories.append(bandHistory)
        
        // sort the history
        bandHistories.sort()
        
        // add the item to the grouped histories
        if let index = groupedHistories.firstIndex(where: { item in
            item.historyDate == bandHistory.dateWorn
        }) {
            groupedHistories[index].BandHistories.append(bandHistory)
            groupedHistories[index].BandHistories.sort { first, second in
                first.timeWorn > second.timeWorn
            }
        }
        else {
            groupedHistories.append(HistoryDate(historyDate: bandHistory.dateWorn, BandHistories: [ bandHistory ]))
            groupedHistories.sort { first, second in
                first.historyDate > second.historyDate
            }
        }
        
        // update the file that will store the new band history
        let calendarComponents = Calendar.current.dateComponents([.year,.month], from: bandHistory.timeWorn)
        let year = calendarComponents.year!
        let month = calendarComponents.month!
        
        do {
            try saveHistory(year: year, month: month)
            return true
        } catch {
            return false
        }
    }
    
    func removeBandHistory(bandHistory: BandHistory) -> Bool {
        // remove the band from the band history
        bandHistories.removeAll(where: { $0 == bandHistory })
        
        // remove the band from the grouped histories
        if let index = groupedHistories.firstIndex(where: { item in
            item.historyDate == bandHistory.dateWorn
        }) {
            groupedHistories[index].BandHistories.removeAll(where: { $0 == bandHistory })
        }
        
        // update the file that will store the new band history
        let calendarComponents = Calendar.current.dateComponents([.year,.month], from: bandHistory.timeWorn)
        let year = calendarComponents.year!
        let month = calendarComponents.month!
        
        do {
            try saveHistory(year: year, month: month)
            return true
        } catch {
            return false
        }
    }
    
    func getCurrentBand() -> BandHistory? {
        if !bandHistories.isEmpty {
            return bandHistories.last
        }
        else {
            return nil
        }
    }
    
    func getYearsWithHistory() -> [BandYear] {
        let allYears: [Int] = bandHistories.map { history in
            let calendarComponents = Calendar.current.dateComponents([.year], from: history.timeWorn)
            return calendarComponents.year!
        }
        
        return Set(allYears).sorted(by: >).map { year in
            BandYear(year: year)
        }
    }
    
    private func getHistoriesGroupedByDate() -> [HistoryDate] {
        var results = [HistoryDate]()
        
        let allDates: [Date] = bandHistories.map { history in
            history.dateWorn
        }
        
        let distinctDates = Array(Set(allDates).sorted(by: >))
        
        for date in distinctDates {
            let histories = bandHistories.filter {item in
                item.dateWorn == date
            }.sorted(by: {$0.timeWorn > $1.timeWorn})
            
            let itemToAdd = HistoryDate(historyDate: date, BandHistories: histories)
            
            results.append(itemToAdd)
        }
        
        return results
    }
    
    func getHistoriesForBand(band: Band) -> [BandHistory] {
        bandHistories.filter { item in
            item.band == band
        }.sorted { first, second in
            first.timeWorn > second.timeWorn
        }
    }
    
    private func getRepositoryFolder() throws -> URL {
        let fileManager = FileManager.default
        
        let rootDocumentFolderUrl = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let repositoryFolderUrl = rootDocumentFolderUrl.appendingPathComponent("Band History Repository")
        
        // create the directory in case it doesn't exist
        if !fileManager.fileExists(atPath: repositoryFolderUrl.path) {
            try fileManager.createDirectory(at: repositoryFolderUrl, withIntermediateDirectories: false)
        }
        
        return repositoryFolderUrl
    }
    
    func getRepositoryFolderSafe() -> String {
        do {
            return try getRepositoryFolder().path
        }
        catch {
            return "{repository directory not found}"
        }
    }
    
    private func loadHistory() {
        do {
            let fileManager = FileManager.default
            let folderUrl = try getRepositoryFolder()
            
            // get list of files
            let folderContents = try fileManager.contentsOfDirectory(at: folderUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            // for each file, open it and add the history to bandHistories
            for file in folderContents {
                do {
                    let fileContents = try String(contentsOf: file)
                    let json = fileContents.data(using: .utf8)!
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    
                    let bandHistories: [BandHistory] = try jsonDecoder.decode(AllBandHistories.self, from: json).bandHistories
                    
                    self.bandHistories.append(contentsOf: bandHistories)
                }
                catch {
                    print("file \(file.lastPathComponent) could not be decoded")
                }
            }
            
            // sort the history
            bandHistories.sort()
        }
        catch {
            print("load history was unsuccessful")
        }
    }
    
    func migrateHistory() {
        do {
            // first delete all existing history
            self.bandHistories.removeAll()
            
            let fileName = "BandMigration.txt"
            let fileManager = FileManager.default
            let folderUrl = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileUrl = folderUrl.appendingPathComponent(fileName)
            
            if FileManager.default.fileExists(atPath: fileUrl.path) {
                let fileContents = try String(contentsOf: fileUrl)
                let fileStrings = fileContents.components(separatedBy: .newlines)
                
                for fileString in fileStrings {
                    let elements = fileString.split(separator: "|")
                    
                    let watch = WatchRepository.default.getWatchByID(UUID(uuidString: String(elements[1]))!)
                    let band = BandRepository.default.getBandByID(UUID(uuidString: String(elements[0]))!)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let timeWorn = dateFormatter.date(from: String(elements[2]))
                    
                    let bandHistory = BandHistory(band: band!, watch: watch!, timeWorn: timeWorn!)
                    
                    self.bandHistories.append(bandHistory)
                }
            }
            // sort the history
            bandHistories.sort()
            
            // generate the files for the history
            var migrationDate = bandHistories.first!.dateWorn
            var migrationDateComponents = Calendar.current.dateComponents([.year, .month], from: migrationDate)
            
            let currentDateComponents = Calendar.current.dateComponents([.year, .month], from: Date.now)
            
            while migrationDateComponents.year! < currentDateComponents.year! || (migrationDateComponents.year! == currentDateComponents.year! && migrationDateComponents.month! <= currentDateComponents.month!) {
                try saveHistory(year: migrationDateComponents.year!, month: migrationDateComponents.month!)
                
                // increment the month
                migrationDate = Calendar.current.date(byAdding: .month, value: 1, to: migrationDate)!
                migrationDateComponents = Calendar.current.dateComponents([.year, .month], from: migrationDate)
            }
        }
        catch {
            print("load history was unsuccessful")
        }
    }
    
    private func saveHistory(year: Int, month: Int) throws {
        // get name of the file where the band history must be saved
        let currentMonthFileName = "BandHistory.\(year).\(month).json"
        
        // get the file
        let folderUrl = try getRepositoryFolder()
        let fileUrl = folderUrl.appendingPathComponent(currentMonthFileName)
        
        // get the list of bands to save to the file
        let bandHistoriesToSave = bandHistories.filter { bandHistory in
            let calendarComponents = Calendar.current.dateComponents([.year,.month], from: bandHistory.timeWorn)
            let bandYear = calendarComponents.year!
            let bandMonth = calendarComponents.month!
            
            return bandYear == year && bandMonth == month
        }
        
        // create the JSON representation of the bands to save
        let allBandHistories = AllBandHistories(bandHistoriesToSave)
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = [.sortedKeys, .prettyPrinted]
        jsonEncoder.dateEncodingStrategy = .iso8601
        
        let jsonData = try jsonEncoder.encode(allBandHistories)
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        // save the bands to the file
        try jsonString?.write(toFile: fileUrl.path, atomically: false, encoding: .utf8)
    }
    
    private var sampleBandHistories: [BandHistory] {
        var result = [BandHistory]()
        
        let watches: [Watch] = [
            Watch(series: 3, material: .aluminum, finish: .spaceGray, size: 42, edition: "Nike"),
            Watch(series: 5, material: .stainlessSteel, finish: .gold, size: 44),
            Watch(series: 7, material: .titanium, finish: .silver, size: 45, edition: "Edition"),
        ]
        
        let bands: [Band] = [
            SportBand(
                color: "Midnight Blue",
                season: Season.fall,
                year: 2018,
                generation: 2),
            SportLoop(
                color: "Surf Blue",
                season: Season.spring,
                year: 2020,
                bandVersion: .twoTone),
            BraidedSoloLoop(
                color: "Atlantic Blue",
                season: Season.fall,
                year: 2020,
                bandSize: 5),
            LeatherLink(
                color: "Midnight",
                season: Season.fall,
                year: 2021,
                bandSize: .smallMedium),
            WovenNylon(
                color: "Pearl",
                season: Season.spring,
                year: 2016,
                bandVersion: .original),
        ]
        
        for i in 1...1000 {
            let band = bands[i % 5]
            let watch = watches[i % 3]
            let timeWorn = Date(timeIntervalSinceNow: (TimeInterval(i * -20000)))
            
            result.append(BandHistory(band: band, watch: watch, timeWorn: timeWorn))
        }
        
        return result
    }
}

struct AllBandHistories: Codable {
    var bandHistories: [BandHistory]
    
    init(_ bandHistories: [BandHistory]) {
        self.bandHistories = bandHistories
    }
}

struct HistoryDate: Identifiable {
    let historyDate: Date
    var BandHistories: [BandHistory]
    let id = UUID()
}

struct BandYear: Identifiable {
    let year: Int
    let id = UUID()
}
