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
    
    @State private var selectedSortOrder: BandSortOrder = .logical
    @State private var selectedSortDirection: SortOrder = .forward
    
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
    }
    
    var body: some View {
        NavigationView {
            List {
                
                Section("Manage Bands") {
                    NavigationLink("Owned Bands") {
                        ManageBandsView(.owned)
                    }
                    
                    NavigationLink("Favorite Bands") {
                        ManageBandsView(.favorite)
                    }
                }
                
                
                Section("Default Band Sort Order") {
                    Picker("Order", selection: $selectedSortOrder) {
                        ForEach(BandSortOrder.allCases) { bandSortOrder in
                            Text(bandSortOrder.rawValue.capitalized)
                        }
                    }
                    Picker("Direction", selection: $selectedSortDirection) {
                        Text("Ascending").tag(SortOrder.forward)
                        Text("Descending").tag(SortOrder.reverse)
                    }
                }
                
                
                
                Section("About") {
                    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
                    
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(appVersion)
                            .foregroundColor(.gray)
                    }
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
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(true)
    }
}
