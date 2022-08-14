//
//  BandHistoryRepository.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/8/22.
//

import Foundation
import SwiftUI

class BandHistoryRepository {
    
    var bandHistories: [BandHistory]
    
    init(_ loadHistories: Bool = true) {
        bandHistories = [BandHistory]()
        if loadHistories {
            loadHistory()
        }
        else {
            bandHistories = SampleBandHistories
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
                    let bandHistories: [BandHistory] = try! JSONDecoder().decode(AllBandHistories.self, from: json).bandHistories
                    
                    self.bandHistories.append(contentsOf: bandHistories)
                }
                catch {
                    print("file \(file.lastPathComponent) could not be decoded")
                }
            }
        }
        catch {
            print("load history was unsuccessful")
            bandHistories = SampleBandHistories
        }
    }
    
    private func saveHistory(year: Int, month: Int) throws {
        // get name of the file where the band history must be saved
        let currentMonthFileName = "BandHistory.\(year).\(month).json"
        
        // get the file
        //let fileManager = FileManager.default
        let folderUrl = try getRepositoryFolder()
        let fileUrl = folderUrl.appendingPathComponent(currentMonthFileName)
        
//            if fileManager.fileExists(atPath: fileUrl.path) {
//                // get file contents
//            }
//            else {
//
//            }
        
        // get the list of bands to save to the file
//            var bandHistoriesToSave: [BandHistory] = [BandHistory]()
//            for bandHistory in bandHistories {
//                let calendarComponents = Calendar.current.dateComponents([.year,.month], from: bandHistory.timeWorn)
//                let bandYear = calendarComponents.year!
//                let bandMonth = calendarComponents.month!
//
//                if bandYear == year && bandMonth == month {
//                    bandHistoriesToSave.append(bandHistory)
//                }
//            }
        
        // get the list of bands to save to the file
        let bandHistoriesToSave = bandHistories.filter { bandHistory in
            let calendarComponents = Calendar.current.dateComponents([.year,.month], from: bandHistory.timeWorn)
            let bandYear = calendarComponents.year!
            let bandMonth = calendarComponents.month!
            
            return bandYear == year && bandMonth == month
        }
        
        // create the JSON representation of the bands to save
        let allBandHistories = AllBandHistories(bandHistoriesToSave)
        let jsonData = try JSONEncoder().encode(allBandHistories)
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        // save the bands to the file
        try jsonString?.write(toFile: fileUrl.path, atomically: false, encoding: .utf8)
    }
    
    func test() {
        do {
            let folderUrl = try getRepositoryFolder()
            let fileUrl = folderUrl.appendingPathComponent("testname.txt")
            
            var dataToWrite = "Apple Watch Band Tracker\n\n"
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .full
            dataToWrite += dateFormatter.string(from: date)
            
            try dataToWrite.write(toFile: fileUrl.path, atomically: false, encoding: String.Encoding.utf8)
        }
        catch {
            print("file write test unsuccessful")
        }
    }
}

struct AllBandHistories: Decodable, Encodable {
    var bandHistories: [BandHistory]
    
    init(_ bandHistories: [BandHistory]) {
        self.bandHistories = bandHistories
    }
}
