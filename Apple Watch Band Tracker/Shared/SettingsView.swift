//
//  SettingsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/7/22.
//

import SwiftUI

struct SettingsView: View {
    
    // define the repositories that this view will use
    private var repository: BandHistoryRepository
    private var bandRepository: BandRepository
    private var watchRepository: WatchRepository
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedSortOrder: BandSortOrder
    @State private var selectedSortDirection: SortOrder
    
    @State private var isPresentingImportConfirm: Bool = false
    @State private var isPresentingExportBandAlert: Bool = false
    @State private var isPresentingExportWatchAlert: Bool = false
    
    @State private var isRefreshInProgress: Bool = false
    @State private var isRefreshComplete: Bool = false
    
    init(_ isPreview: Bool = false) {
        if isPreview {
            self.repository = BandHistoryRepository.sample
            self.bandRepository = BandRepository.sample
            self.watchRepository = WatchRepository.sample
        }
        else {
            self.repository = BandHistoryRepository.default
            self.bandRepository = BandRepository.default
            self.watchRepository = WatchRepository.default
        }
        
        
        _selectedSortOrder = .init(initialValue: bandRepository.defaultSortOrder)
        _selectedSortDirection = .init(initialValue: bandRepository.defaultSortDirection)
    }
    
    var body: some View {
        NavigationStack {
            List {
                
                Section("About") {
                    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
                    
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(appVersion)
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Manage Data") {
                    if (!isRefreshInProgress && !isRefreshComplete) {
                        Button {
                            isRefreshInProgress = true
                            Task {
                                print("kick off refresh")
                                BandHistoryRepository.default.refreshData()
                                print("refresh complete")
                                isRefreshComplete = true
                                isRefreshInProgress = false
                            }
                        } label: {
                            Label("Force Refresh All Data", systemImage: "arrow.clockwise")
                        }
                    }
                    if (isRefreshInProgress) {
                        Text("Refresh in Progress...")
                    }
                    if (isRefreshComplete) {
                        Text("Refresh Complete!")
                    }
                }
                
                Section("Manage Bands") {
                    NavigationLink("Owned Bands") {
                        ManageBandsView(.owned)
                    }
                    
                    NavigationLink("Favorite Bands") {
                        ManageBandsView(.favorite)
                    }
                }
                
                Section("Manage Watches") {
                    NavigationLink("Owned Watches") {
                        ManageWatchesView()
                    }
                }
                
                Section("Default Band Sorting") {
                    Picker("Order", selection: $selectedSortOrder) {
                        ForEach(BandSortOrder.allCases) { bandSortOrder in
                            Text(bandSortOrder.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.menu)
                    Picker("Direction", selection: $selectedSortDirection) {
                        Text("Ascending").tag(SortOrder.forward)
                        Text("Descending").tag(SortOrder.reverse)
                    }
                    .pickerStyle(.menu)
                }
                
                Section {
                    Button {
                        isPresentingImportConfirm = true
                    } label: {
                        Label("Import Band History Data", systemImage: "square.and.arrow.down.fill")
                    }
                    .confirmationDialog("Are you sure?", isPresented: $isPresentingImportConfirm) {
                        Button("Delete all history and import?", role: .destructive) {
                            BandHistoryRepository.default.migrateHistory()
                        }
                    }
                    Button {
                        if BandRepository.default.saveBands() {
                            isPresentingExportBandAlert = true
                        }
                    } label: {
                        Label("Export Band Data", systemImage: "square.and.arrow.up.fill")
                    }
                    .alert("Bands successfully exported.", isPresented: $isPresentingExportBandAlert) { }
                    Button {
                        if WatchRepository.default.saveWatches() {
                            isPresentingExportWatchAlert = true
                        }
                    } label: {
                        Label("Export Watch Data", systemImage: "square.and.arrow.up.fill")
                    }
                    .alert("Watches successfully exported.", isPresented: $isPresentingExportWatchAlert) { }
                } header: {
                    Text("Migrate Data")
                }
                
                Section("Band Repository Directory") {
                    Text(repository.getRepositoryFolderSafe())
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("tapped done")
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Label("Done", systemImage: "xmark.circle")
                            .labelStyle(.titleOnly)
                    }
                }
            }
        }
        .onDisappear {
            bandRepository.defaultSortOrder = selectedSortOrder
            bandRepository.defaultSortDirection = selectedSortDirection
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(true)
    }
}
