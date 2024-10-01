//
//  HistoryView.swift
//  Apple Watch Band Tracker
//
//  Created by Nick Haberman on 8/6/22.
//

import SwiftUI

struct HistoryView: View {
//    init() {
//        Theme.navigationBarColors(background: .blue, titleColor: .white)
//    }
    
    // define the repositories that this view will use
    private var repository: BandHistoryRepository
    
    init() {
        self.repository = BandHistoryRepository.sample
        self.pageTitle = "Sample History"
        self.startDate = Date.distantPast
        self.endDate = Date.distantFuture
    }
    
    init(pageTitle: String, lookBackType: HistoryLookBack, lookBackYear: Int = 0) {
        self.repository = BandHistoryRepository.default
        self.pageTitle = pageTitle
        
        // calculate the start and end dates based on the type of lookback
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .weekday], from: Date())
        let todaysDate = Calendar.current.date(from: dateComponents)!
        
        switch (lookBackType) {
        case .recent:
            self.startDate = Calendar.current.date(byAdding: .day, value: -7, to: todaysDate)!
            self.endDate = Date.distantFuture
        case .specificYear:
            let startDateComponents = DateComponents.init(year: lookBackYear, month: 1, day: 1)
            self.startDate = Calendar.current.date(from: startDateComponents)!
            
            let endDateComponents = DateComponents.init(year: lookBackYear + 1, month: 1, day: 1)
            let firstDayOfNextYear = Calendar.current.date(from: endDateComponents)!
            self.endDate = Calendar.current.date(byAdding: .day, value: -1, to: firstDayOfNextYear)!
        case .all:
            self.startDate = Date.distantPast
            self.endDate = Date.distantFuture
        case .none:
            self.startDate = Date()
            self.endDate = Date()
        }
    }
    
    var startDate: Date
    var endDate: Date
    var pageTitle: String = "No Title Supplied"
    
    @State private var showTrackBandSheet = false
    @State private var showingAlert = false
    
    enum HistoryLookBack {
        case none, recent, specificYear, all
    }
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            List {
                ForEach(repository.groupedHistories) { item in
                    if (item.historyDate >= startDate && item.historyDate <= endDate) {
                        Section(header: Text(item.historyDate.formatted(date: .complete, time: .omitted))) {
                            ForEach(item.BandHistories) { subItem in
                                NavigationLink {
                                    BandHistoryDetailsView(bandHistory: subItem.self)
                                } label: {
                                    BandHistoryView(bandHistory: subItem.self)
                                }
                                .swipeActions(allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        let wasSuccessful = repository.removeBandHistory(bandHistory: subItem)
                                        
                                        if !wasSuccessful {
                                            showingAlert = true
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                .swipeActions {
                                    Button {
                                        print("test edit")
                                    } label: {
                                        Label("Edit", systemImage: "square.and.pencil")
                                    }
                                    .tint(.blue)
                                }
                            }
                        }
                    }
                }
            }
//            .refreshable(action: {
//                // code to refresh the list
//                await repository.getHistoriesGroupedByDateAsync()
//            })
            .listStyle(.insetGrouped)
        }
        .navigationTitle(pageTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("tapped track band")
                    showTrackBandSheet = true
                } label: {
                    Label("Track Band", systemImage: "plus.circle.fill")
                }
            }
        }
        .sheet(isPresented: $showTrackBandSheet, onDismiss: {
            print("goodbye track band sheet")
        }, content: {
            TrackBandView()
        })
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Unable to Delete Band History"),
                message: Text("There was an error deleting the band history, it may not have been deleted."),
                dismissButton: .default(Text("OK")))
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
