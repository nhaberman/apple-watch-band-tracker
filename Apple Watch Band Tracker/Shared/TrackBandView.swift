//
//  TrackBandView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct TrackBandView: View {
    init(_ repository: BandHistoryRepository) {
        //Theme.navigationBarColors(background: .blue, titleColor: .white)
        self.repository = repository
    }
    
    let repository: BandHistoryRepository
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedWatch: Watch = Watch(series: -1, color: "", size: 0)
    @State private var selectedBandType: BandType = BandType.None
    @State private var selectedBand: Band = Band(color: "", season: .spring, year: 0)
    @State private var selectedDate = Date()
    @State private var useCurrentDate = true
    
    private let bandRepository = BandRepository()
    
    var body: some View {
        NavigationView {
            Form {
                Section("Select the Apple Watch:") {
                    Picker("Watch", selection: $selectedWatch) {
                        ForEach(WatchRepository().allWatches, id: \.self) { watch in
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
                            ForEach(bandRepository.getBandsByType(selectedBandType), id: \.self) { band in
                                Text(band.formattedName())
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
                    
                    let bandHistory = BandHistory(band: selectedBand, watch: selectedWatch, timeWorn: selectedDate)
                    let wasSuccessful = repository.trackBand(bandHistory: bandHistory)
                    
//                    if wasSuccessful {
//                        Alert(title: Text("Error"), message: Text("Could not track band"), dismissButton: .cancel())
//                    }
                    
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
        TrackBandView(BandHistoryRepository(false))
    }
}
