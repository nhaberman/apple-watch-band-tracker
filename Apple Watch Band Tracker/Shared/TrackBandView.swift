//
//  TrackBandView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct TrackBandView: View {
    init() {
        //Theme.navigationBarColors(background: .blue, titleColor: .white)
    }
    
    @Environment(\.presentationMode) var presentationMode
    
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
                
                Text("Select Band Color")
                    .padding()
                
                Text("Select Time")
                    .padding()
                
                Button {
                    print("Save Band")
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "applewatch.side.right")
                            .font(.title)
                        Text("Track Band")
                    }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(6)
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
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
        TrackBandView()
    }
}
