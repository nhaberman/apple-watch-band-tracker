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
        NavigationView {
            Form {
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
                    if selectedBandType != .None {
                        List {
                            let bandsByType = GlobalBandRepository.getBandsByType(selectedBandType, sortOrder: .logical)
                            Picker("Band", selection: $selectedBand) {
                                ForEach(bandsByType, id: \.self) { band in
                                    Text(band.formattedName())
                                }
                            }
                        }
                    }
                }
                Section("Select the Apple Watch:") {
                    Picker("Watch", selection: $selectedWatch) {
                        ForEach(WatchRepository().allWatches, id: \.self) { watch in
                            Text(watch.formattedName())
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
                        Label("Cancel", systemImage: "xmark.circle")
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
            let wasSuccessful = GlobalBandHistoryRepository.trackBand(bandHistory: bandHistory)
            
            if !wasSuccessful {
                showingAlert = true
            }
            else {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
}

struct TrackBandView_Previews: PreviewProvider {
    static var previews: some View {
        TrackBandView()
            .previewInterfaceOrientation(.portrait)
    }
}
