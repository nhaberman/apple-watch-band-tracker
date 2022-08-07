//
//  HistoryView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct HistoryView: View {
    init() {
        //Theme.navigationBarColors(background: .blue, titleColor: .white)
    }
    
    @State private var showTrackBandSheet = false
    @State private var showSettingsSheet = false
    
    var body: some View {
        NavigationView {
            VStack(
                alignment: .leading
            ) {
                List(BandType.allCases) { value in
                    Text(value.rawValue)
                   }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationTitle("Band History")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("tapped settings")
                        showSettingsSheet = true
                    } label: {
                        Label("Settings", systemImage: "gear.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("tapped track band")
                        showTrackBandSheet = true
                    } label: {
                        Label("Track Band", systemImage: "plus.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $showTrackBandSheet, onDismiss: {
            print("goodbye track band sheet")
        }, content: {
            TrackBandView()
        })
        
        .sheet(isPresented: $showSettingsSheet, onDismiss: {
            print("goodbye settings sheet")
        }, content: {
            SettingsView()
        })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
