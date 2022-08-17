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
    
    init(_ isPreview: Bool = false) {
        if isPreview {
            self.repository = BandHistoryRepository.sample
            self.bandRepository = BandRepository.sample
            self.watchRepository = WatchRepository.sample
        }
        else {
            self.repository = GlobalBandHistoryRepository
            self.bandRepository = GlobalBandRepository
            self.watchRepository = GlobalWatchRepository
        }
    }
    
    var body: some View {
        NavigationView {
            List {
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
