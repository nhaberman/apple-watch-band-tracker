//
//  AllBandsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct BandsView: View {
    init() {
        //Theme.navigationBarColors(background: .blue, titleColor: .white)
    }
    
    @State private var showSettingsSheet = false
    
    var body: some View {
        NavigationView {
            VStack(
                alignment: .leading
            ) {
                List(BandType.allCases) { value in
                    if (value != BandType.None) {
                        Text(value.rawValue)
                    }
                }
                let bandRepository = BandRepository()
                
                List(bandRepository.allBands) {
                    BandView(band: $0.self)
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

struct BandsView_Previews: PreviewProvider {
    static var previews: some View {
        BandsView()
    }
}
