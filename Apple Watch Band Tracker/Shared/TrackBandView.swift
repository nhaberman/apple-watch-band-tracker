//
//  TrackBandView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct TrackBandView: View {
    init() {
        //Theme.navigationBarColors(background: .blue, titleColor: .white)
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedWatch: Watch = Watch()
    @State private var selectedBandType: BandType = BandType.None
    @State private var selectedBand: WatchBand = WatchBand()
    @State private var selectedDate = Date()
    @State private var useCurrentDate = true
    
    var body: some View {
        NavigationView {
            Form {
                Section("Select the Apple Watch:") {
                    Picker("Watch", selection: $selectedWatch) {
                        ForEach(Watches, id: \.self) { watch in
                            Text(watch.formattedName())
                        }
                    }
                }
                Section("Select the Band:") {
                    List {
                        Picker("Band Type", selection: $selectedBandType) {
                            ForEach(BandType.allCases) { bandType in
                                if (bandType != BandType.None) {
                                    Text(bandType.rawValue)
                                }
                            }
                        }
                    }
                    List {
                        Picker("Band", selection: $selectedBand) {
                            ForEach(WatchBands, id: \.self) { band in
                                if (band.bandType == selectedBandType) {
                                    Text(band.formattedColorName())
                                }
                            }
                        }
                    }
                }
                Section("Select the Time:") {
                    Toggle(isOn: $useCurrentDate) {
                        Text("Use Current Time")
                    }
                    if (!useCurrentDate) {
                        DatePicker("Time Worn", selection: $selectedDate)
                    }
                }
                
                Button {
                    print("Save Band")
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "applewatch.side.right")
                            .font(.title)
                        Text("Track Band")
                    }
                }
            }
            .navigationTitle("Track Band")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("tapped cancel")
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Label("Cancel", systemImage: "xmark.circle")
                    }
                }
            }
        }
    }
}

struct TrackBandView_Previews: PreviewProvider {
    static var previews: some View {
        TrackBandView()
    }
}

private var Watches = [
    Watch(series: 0, color: "Stainless Steel", size: 42),
    Watch(series: 0, color: "Stainless Steel", size: 38),
    Watch(series: 2, color: "Space Black Stainless Steel", size: 42),
    Watch(series: 3, color: "Space Gray Aluminum", edition: "Nike", size: 42),
    Watch(series: 5, color: "Gold Stainless Steel", size: 44),
    Watch(series: 5, color: "Space Black Stainless Steel", size: 44),
    Watch(series: 7, color: "Titanium", edition: "Edition", size: 45),
]


private var WatchBands = [
    WatchBand(
        bandType: BandType.SportBand,
        color: "Capri Blue",
        season: Season.spring,
        year: 2021),
    WatchBand(
        bandType: BandType.ClassicBuckle,
        color: "Saddle Brown",
        generation: 3,
        season: Season.fall,
        year: 2017),
    WatchBand(
        bandType: BandType.SportBand,
        color: "Plum",
        season: Season.winter,
        year: 2020),
    WatchBand(
        bandType: BandType.SportBand,
        color: "Capri Blue",
        season: Season.spring,
        year: 2021),
    WatchBand(
        bandType: BandType.ClassicBuckle,
        color: "Saddle Brown",
        generation: 3,
        season: Season.fall,
        year: 2017),
    WatchBand(
        bandType: BandType.SportBand,
        color: "Plum",
        season: Season.winter,
        year: 2020),
    WatchBand(
        bandType: BandType.SportBand,
        color: "Capri Blue",
        season: Season.spring,
        year: 2021),
    WatchBand(
        bandType: BandType.ClassicBuckle,
        color: "Saddle Brown",
        generation: 3,
        season: Season.fall,
        year: 2017),
    WatchBand(
        bandType: BandType.SportBand,
        color: "Plum",
        season: Season.winter,
        year: 2020),
]
