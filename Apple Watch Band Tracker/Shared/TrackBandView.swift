//
//  TrackBandView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct TrackBandView: View {
    var body: some View {
        NavigationView {
            VStack(
                alignment: .leading
            ) {
                GroupBox(
                    label: Text("Select Apple Watch")) {
                    List {
                        Text("test1")
                        Text("test1")
                        Text("test1")
                    }
                }
                
                GroupBox(
                    label: Text("Select Band Type")) {
                    List {
                        Text("test1")
                        Text("test1")
                        Text("test1")
                    }
                }
                Text("Select Band Type")
                    .padding()
                
                Text("Select Band Color")
                    .padding()
                
                Text("Select Time")
                    .padding()
                
                Text("Button to save")
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationTitle("Track Band")
        }
    }
}

struct TrackBandView_Previews: PreviewProvider {
    static var previews: some View {
        TrackBandView()
    }
}
