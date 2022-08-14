//
//  BandHistoryRepository.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/8/22.
//

import Foundation

class BandHistoryRepository {
    
    var bandHistories: [BandHistory]
    
    init() {
        bandHistories = [BandHistory]()
        test()
        
    }
    
    func getRepositoryFolder() throws -> URL {
        let fileManager = FileManager.default
        
        let rootDocumentFolderUrl = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let repositoryFolderUrl = rootDocumentFolderUrl.appendingPathComponent("Band History Repository")
        
        // create the directory in case it doesn't exist
        if !fileManager.fileExists(atPath: repositoryFolderUrl.path) {
            try fileManager.createDirectory(at: repositoryFolderUrl, withIntermediateDirectories: false)
        }
        
        return repositoryFolderUrl
    }
    
    func loadHistory() {
        do {
            let folderUrl = try getRepositoryFolder()
        }
        catch {
            print("load history was unsuccessful")
            bandHistories = SampleBandHistories
        }
    }
    
    func saveBandHistory(bandHistory: BandHistory) throws {
        
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

struct AllBandHistories: Decodable {
    var bandHistories: [BandHistory]
}
