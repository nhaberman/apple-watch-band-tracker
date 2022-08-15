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
        self.repository = GlobalBandHistoryRepository
        self.pageTitle = pageTitle
        
        // calculate the start and end dates based on the type of lookback
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .weekday], from: Date())
        let todaysDate = Calendar.current.date(from: dateComponents)!
        
        switch (lookBackType) {
        case .currentDay:
            self.startDate = todaysDate
            self.endDate = Date.distantFuture
        case .currentWeek:
            self.startDate = Calendar.current.date(byAdding: .day, value: -1 * (dateComponents.weekday! - 1), to: todaysDate)!
            self.endDate = Date.distantFuture
        case .currentMonth:
            self.startDate = Calendar.current.date(byAdding: .day, value: -1 * (dateComponents.day! - 1), to: todaysDate)!
            self.endDate = Date.distantFuture
        case .currentYear:
            let firstOfMonth = Calendar.current.date(byAdding: .day, value: -1 * (dateComponents.day! - 1), to: todaysDate)!
            self.startDate = Calendar.current.date(byAdding: .month, value: -1 * (dateComponents.month! - 1), to: firstOfMonth)!
            self.endDate = Date.distantFuture
        case .specificYear:
            let startDateComponents = DateComponents.init(year: lookBackYear, month: 1, day: 1)
            let endDateComponents = DateComponents.init(year: lookBackYear + 1, month: 1, day: 1)
            
            self.startDate = Calendar.current.date(from: startDateComponents)!
            self.endDate = Calendar.current.date(from: endDateComponents)!
        case .all:
            self.startDate = Date.distantPast
            self.endDate = Date.distantFuture
        case .none:
            self.startDate = Date()
            self.endDate = Date()
        }
        
        print(pageTitle)
        print("start date:  \(startDate)")
        print("end date:  \(endDate)")
    }
    
    var startDate: Date
    var endDate: Date
    var pageTitle: String = "No Title Supplied"
    
    @State private var showTrackBandSheet = false
    
    enum HistoryLookBack {
        case none, currentDay, currentWeek, currentMonth, currentYear, specificYear, all
    }
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            List {
                ForEach(repository.getHistoriesGroupedByDate()) { item in
                    if (item.historyDate >= startDate && item.historyDate <= endDate) {
                        Section(header: Text(item.historyDate.formatted(date: .complete, time: .omitted))) {
                            ForEach(item.BandHistories) { subItem in
                                NavigationLink {
                                    BandHistoryDetailsView(bandHistory: subItem.self)
                                } label: {
                                    BandHistoryView(bandHistory: subItem.self)
                                }
                            }
                        }
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        print("test delete")
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
            .refreshable(action: {
                // code to refresh the list
            })
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
                    Label("Track Band", systemImage: "plus.circle")
                }
            }
        }
        .sheet(isPresented: $showTrackBandSheet, onDismiss: {
            print("goodbye track band sheet")
        }, content: {
            TrackBandView()
        })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
