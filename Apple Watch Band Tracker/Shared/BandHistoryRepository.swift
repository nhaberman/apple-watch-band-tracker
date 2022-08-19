//
//  BandHistoryRepository.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/8/22.
//

import Foundation
import SwiftUI

class BandHistoryRepository {
    // sample repository
    static let sample = BandHistoryRepository(false)
    
    var bandHistories: [BandHistory]
    
    init(_ loadHistories: Bool = true) {
        self.bandHistories = [BandHistory]()
        
        if loadHistories {
            loadHistory()
        }
        else {
            bandHistories = sampleBandHistories
        }
    }
    
    func trackBand(bandHistory: BandHistory, addBandHistory: Bool = true) -> Bool {
        // add or remove the band to or from the band history
        if addBandHistory {
            bandHistories.append(bandHistory)
        }
        else {
            bandHistories.removeAll(where: { $0 == bandHistory })
        }
        
        // sort the history
        bandHistories.sort()
        
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
    
    func getHistoriesGroupedByDate() -> [HistoryDate] {
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
                    
                    let bandHistories: [BandHistory] = try! jsonDecoder.decode(AllBandHistories.self, from: json).bandHistories
                    
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
        jsonEncoder.outputFormatting = .prettyPrinted
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
    let BandHistories: [BandHistory]
    let id = UUID()
}

struct BandYear: Identifiable {
    let year: Int
    let id = UUID()
}
