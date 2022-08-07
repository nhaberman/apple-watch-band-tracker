//
//  SettingsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/7/22.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(
                alignment: .leading
            ) {
                Text("setting 1")
                    .padding()
                
                Text("setting 2")
                    .padding()
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
        SettingsView()
    }
}
