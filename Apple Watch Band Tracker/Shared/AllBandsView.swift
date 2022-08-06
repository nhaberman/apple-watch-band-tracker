//
//  AllBandsView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct AllBandsView: View {
    var body: some View {
        VStack {
            Text("Hello, world! (4)")
                .padding()
            (Button("Button") {
                print("test")
            }).padding()
            Button("Test Button Again",
                   action: TestAction)
            .padding()
        }.buttonStyle(.bordered)
    }
}

struct AllBandsView_Previews: PreviewProvider {
    static var previews: some View {
        AllBandsView()
    }
}


func TestAction() {
    // Do whatever you need when the button is pressed
    print("Hello World test?")
}
