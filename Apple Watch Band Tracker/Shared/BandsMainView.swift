//
//  AllBandsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct BandsMainView: View {
    init(_ repository: BandHistoryRepository) {
        //Theme.navigationBarColors(background: .blue, titleColor: .white)
        self.repository = repository
    }
    
    let repository: BandHistoryRepository
    
    @State private var showSettingsSheet = false
    
    var body: some View {
        NavigationView {
            VStack(
                alignment: .leading
            ) {
                List(BandType.allCases) { value in
                    if (value != BandType.None) {
                        NavigationLink {
                            BandsView(repository: repository, bandType: value)
                        } label: {
                            Label(value.rawValue, systemImage: "applewatch.side.right")
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationTitle("Bands")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("tapped settings")
                        showSettingsSheet = true
                    } label: {
                        Label("Settings", systemImage: "gear.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $showSettingsSheet, onDismiss: {
            print("goodbye settings sheet")
        }, content: {
            SettingsView()
        })
    }
}

struct BandsMainView_Previews: PreviewProvider {
    static var previews: some View {
        BandsMainView(BandHistoryRepository(false))
    }
}
