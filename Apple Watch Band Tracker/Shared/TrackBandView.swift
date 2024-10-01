//
//  TrackBandView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct TrackBandView: View {
//    init() {
//        Theme.navigationBarColors(background: .blue, titleColor: .white)
//    }
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedWatch: Watch = Watch(series: -1, material: .none, finish: .none, size: 0)
    @State private var selectedBandType: BandType = .None
    @State private var selectedBand: Band = Band(color: "", season: .spring, year: 0)
    @State private var selectedDate = Date()
    @State private var useCurrentDate = true
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Select the Band:") {
                    List {
                        Picker("Band Type", selection: $selectedBandType) {
                            ForEach(BandType.getAllBandTypes()) { bandType in
                                Text(bandType.rawValue)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                    if selectedBandType != .None {
                        List {
                            let bandsByType = BandRepository.default.getBandsByType(selectedBandType, sortOrder: BandRepository.default.defaultSortOrder, sortDirection: BandRepository.default.defaultSortDirection, useFavorites: true)
                            Picker("Band", selection: $selectedBand) {
                                ForEach(bandsByType, id: \.self) { band in
                                    if band.isOwned {
                                        Text(band.formattedName())
                                            .fontWeight(band.isFavorite ? .semibold : .regular)
                                    }
                                }
                            }
                            .pickerStyle(.navigationLink)
                        }
                    }
                }
                Section("Select the Apple Watch:") {
                    Picker("Watch", selection: $selectedWatch) {
                        ForEach(WatchRepository().allWatches.reversed(), id: \.self) { watch in
                            Text(watch.formattedNameOneLine(useShortFormat: false))
                        }
                    }
                    .pickerStyle(.navigationLink)
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
                    saveBand()
                } label: {
                    HStack {
                        Image(systemName: "applewatch.side.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20, alignment: .center)
                        Text("Track Band")
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Unable to Track Band"),
                    message: Text("A value is required for all fields in order to track the band."),
                    dismissButton: .default(Text("OK")))
            }
//            .actionSheet(isPresented: $showingAlert) {
//                ActionSheet(title: Text("Unable to Track Band"), message: Text("A value is required for all fields in order to track the band."), buttons: [.default(Text("one")){}, .default(Text("two")){ presentationMode.wrappedValue.dismiss()}, .cancel()])
//            }
            .navigationTitle("Track Band")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("tapped cancel")
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Label("Cancel", systemImage: "xmark.circle.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Section("Randomize") {
                            Button("Any Band") {
                                print("tapped any random band")
                                randomizeBand()
                            }
    //                        Button("Not Worn this Month") {
    //                            print("tapped random band not recently worn")
    //                            randomizeBand(excludeRecentBands: true)
    //                        }
    //                        Button("Not Worn this Year") {
    //                            print("tapped random band not recently worn")
    //                            randomizeBand(excludeRecentBands: true)
    //                        }
                        }
                        Divider()
                        Section("Specific Band Type") {
                            ForEach(BandType.getAllBandTypes()) { bandType in
                                Button(bandType.rawValue) {
                                    print("tapped random band from type: \(bandType.rawValue)")
                                    randomizeBand(bandType: bandType)
                                }
                            }
                        }
                    } label: {
                        Label("Randomize", systemImage: "dice.fill")
                    } primaryAction: {
                        print("tapped random by default")
                        randomizeBand()
                    }
                }
            }
        }
    }
    
    func saveBand() {
        // confirm that a band and watch were selected
        if selectedWatch.series == -1 || selectedBandType == .None || selectedBand.color == "" {
            showingAlert = true
        }
        else {
            let bandHistory = BandHistory(band: selectedBand, watch: selectedWatch, timeWorn: selectedDate)
            let wasSuccessful = BandHistoryRepository.default.trackBand(bandHistory: bandHistory)
            
            if !wasSuccessful {
                showingAlert = true
            }
            else {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func randomizeBand(excludeRecentBands: Bool = false, bandType: BandType = .None) {
        var randomBand: Band
        
        // get a random band
        if (excludeRecentBands) {
            //randomBand = BandRepository.default.getRandomOwnedBand()!
            randomBand = SportBand(color: "White", season: .spring, year: 2015)
        } else {
            randomBand = BandRepository.default.getRandomOwnedBand(bandType)!
        }
        
        print("retrieved random band:  \(randomBand.bandType), \(randomBand.formattedName())")
        
        // set the properties to match the random band
        selectedBandType = randomBand.bandType
        selectedBand = randomBand
    }
    
}

struct TrackBandView_Previews: PreviewProvider {
    static var previews: some View {
        TrackBandView()
            .previewInterfaceOrientation(.portrait)
    }
}
