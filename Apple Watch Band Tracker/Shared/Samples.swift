//
//  Samples.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/8/22.
//

import Foundation

let SampleBands = [
    Band(
        bandType: BandType.SportBand,
        color: "Capri Blue",
        season: Season.spring,
        year: 2021),
    Band(
        bandType: BandType.ClassicBuckle,
        color: "Saddle Brown",
        generation: 3,
        season: Season.fall,
        year: 2017),
    Band(
        bandType: BandType.SportBand,
        color: "Plum",
        season: Season.winter,
        year: 2020),
    Band(
        bandType: BandType.SportBand,
        color: "Capri Blue",
        season: Season.spring,
        year: 2021),
    Band(
        bandType: BandType.ClassicBuckle,
        color: "Saddle Brown",
        generation: 3,
        season: Season.fall,
        year: 2017),
    Band(
        bandType: BandType.SportBand,
        color: "Plum",
        season: Season.winter,
        year: 2020),
    Band(
        bandType: BandType.SportBand,
        color: "Capri Blue",
        season: Season.spring,
        year: 2021),
    Band(
        bandType: BandType.ClassicBuckle,
        color: "Saddle Brown",
        generation: 3,
        season: Season.fall,
        year: 2017),
    Band(
        bandType: BandType.SportBand,
        color: "Plum",
        season: Season.winter,
        year: 2020),
]

func generateSampleBandHistories() -> [BandHistory] {
    var results = [BandHistory]()
    
    for i in 1...1000 {
        var band : Band
        var watch : Watch
        
        switch i % 5 {
        case 0:
            band = Band(
                bandType: BandType.SportBand,
                color: "Midnight Blue",
                generation: 2,
                season: Season.fall,
                year: 2018)
        case 1:
            band = Band(
                bandType: BandType.SportLoop,
                color: "Surf Blue",
                season: Season.spring,
                year: 2020)
        case 2:
            band = Band(
                bandType: BandType.BraidedSoloLoop,
                color: "Atlantic Blue",
                season: Season.fall,
                year: 2020)
        case 3:
            band = Band(
                bandType: BandType.LeatherLink,
                color: "Midnight",
                season: Season.fall,
                year: 2021)
        default:
            band = Band(
                bandType: BandType.WovenNylon,
                color: "Pearl",
                season: Season.spring,
                year: 2016)
        }
        
        switch i % 3 {
        case 0:
            watch = Watch(series: 3, color: "Space Gray Aluminum", edition: "Nike", size: 42)
        case 1:
            watch = Watch(series: 5, color: "Gold Stainless Steel", size: 44)
        default:
            watch = Watch(series: 7, color: "Titanium", edition: "Edition", size: 45)
        }
        
        let timeWorn = Date(timeIntervalSinceNow: (TimeInterval(i * -20000)))
        
        results.append(BandHistory(band: band, watch: watch, timeWorn: timeWorn))
    }
    
    return results
}

let SampleBandHistories = generateSampleBandHistories()

func groupHistoriesByDate() -> [HistoryDate] {
    var results = [HistoryDate]()
    
    let allDates: [Date] = SampleBandHistories.map { history in
        history.dateWorn
    }
    
    let distinctDates = Array(Set(allDates).sorted(by: >))
    
    for date in distinctDates {
        let histories = SampleBandHistories.filter {item in
            item.dateWorn == date
        }
        
        let itemToAdd = HistoryDate(historyDate: date, BandHistories: histories)
        
        results.append(itemToAdd)
    }
    
    return results
}

let SampleBandHistoriesGrouped: [HistoryDate] = groupHistoriesByDate()

let SampleWatches = [
    Watch(series: 0, color: "Stainless Steel", size: 42),
    Watch(series: 0, color: "Stainless Steel", size: 38),
    Watch(series: 2, color: "Space Black Stainless Steel", size: 42),
    Watch(series: 3, color: "Space Gray Aluminum", edition: "Nike", size: 42),
    Watch(series: 5, color: "Gold Stainless Steel", size: 44),
    Watch(series: 5, color: "Space Black Stainless Steel", size: 44),
    Watch(series: 7, color: "Titanium", edition: "Edition", size: 45),
]
