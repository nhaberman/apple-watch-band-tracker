//
//  AddWatchView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 4/10/23.
//

import SwiftUI

struct AddWatchView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedSeriesModel: String? = nil
    @State private var selectedMaterial: WatchCaseMaterial = .none
    @State private var selectedFinish: WatchCaseFinish = .none
    @State private var selectedEdition: String? = nil
    @State private var selectedSize: String? = nil
    
    @State private var showingAlert = false
       
    var body: some View {
        NavigationView {
            Form {
                Section("Enter the Watch information:") {
                    List {
                        Picker("Series/Model", selection: $selectedSeriesModel) {
                            Text("Select").tag(String?.none)
                            ForEach(getAllWatchSeriesModelOptions(), id: \.self) { option in
                                Text(option).tag(String?.some(option))
                            }
                        }
                        .pickerStyle(.menu)
                        
                        if selectedSeriesModel != nil {
                            
                            if getAllWatchEditionOptions().count > 0 {
                                Picker("Edition", selection: $selectedEdition) {
                                    Text("Select").tag(String?.none)
                                    ForEach(getAllWatchEditionOptions(), id: \.self) { edition in
                                        Text(edition).tag(String?.some(edition))
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                        
                            Picker("Size", selection: $selectedSize) {
                                Text("Select").tag(String?.none)
                                ForEach(getAllWatchSizeOptions(), id: \.self) { size in
                                    Text(size).tag(String?.some(size))
                                }
                            }
                            .pickerStyle(.menu)
                            
                            
                            Picker("Case Material", selection: $selectedMaterial) {
                                Text("Select").tag(Optional<WatchCaseMaterial>(nil))
                                ForEach(WatchCaseMaterial.allCases, id: \.self) { material in
                                    Text(material.rawValue)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        if selectedMaterial != .none {
                            Picker("Case Finish", selection: $selectedFinish) {
                                Text("Select").tag(Optional<WatchCaseFinish>(nil))
                                ForEach(WatchCaseFinish.allCases, id: \.self) { finish in
                                    Text(finish.rawValue)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                    }
                }
                
                Button {
                    print("Add Watch")
                    saveWatch()
                } label: {
                    HStack {
                        Image(systemName: "applewatch")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20, alignment: .center)
                        Text("Add Watch")
                    }
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Unable to Add Watch"),
                message: Text("A value is required for all fields in order to add the band."),
                dismissButton: .default(Text("OK")))
        }
        .navigationTitle("Add Watch")
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
    
    func saveWatch() {
        
    }
    
    func getAllWatchSeriesModelOptions() -> [String] {
        var allValues = ["1st Generation"]
        
        for i in 1...8 {
            allValues.append("Series \(i)")
        }
        
        allValues.append("SE")
        allValues.append("SE 2")
        allValues.append("Ultra")
        
        return allValues
    }
    
    func getAllWatchEditionOptions() -> [String] {
        var allValues: [String] = []
        
        if ["1st Generation", "Series 2", "Series 3", "Series 5", "Series 6", "Series 7"].contains(selectedSeriesModel) {
            allValues.append("Edition")
        }
        if ["Series 2", "Series 3", "Series 4", "Series 5", "Series 6", "Series 7", "SE"].contains(selectedSeriesModel) {
            allValues.append("Nike")
        }
        if ["Series 2", "Series 3", "Series 4", "Series 5", "Series 6", "Series 7", "Series 8"].contains(selectedSeriesModel) {
            allValues.append("Hermès")
        }
        
        return allValues
    }
    
    func getAllWatchSizeOptions() -> [String] {
        switch selectedSeriesModel {
        case "1st Generation", "Series 1", "Series 2", "Series 3":
            return ["38 mm", "42 mm"]
        case "Series 4", "Series 5", "Series 6", "SE", "SE 2":
            return ["40 mm", "44 mm"]
        case "Series 7", "Series 8":
            return ["41 mm", "45 mm"]
        case "Ultra":
            return ["49 mm"]
        default:
            return []
        }
    }
}

struct AddWatchView_Previews: PreviewProvider {
    static var previews: some View {
        AddWatchView()
    }
}
