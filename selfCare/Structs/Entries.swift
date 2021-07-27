//
//  EntryStruct.swift
//  selfCare
//
//  Created by Joseph Taylor on 08/05/2021.
//

import Foundation
import SwiftUI
import SwiftUICharts
import UserNotifications

struct Entry: Identifiable, Codable {
    let id: String
    let rating: Double
    let ratingString: String
    let reflectionText: String
    let happyText: String
    let achievementText: String
    let mood: Mood
    let date: Date
    let exercise: Bool
    let water: Bool
    let sleep: Bool
    let meditation: Bool
    let fruit: Bool
    let reading: Bool
    let productivity: Bool
    let outside: Bool
    
    enum Mood: String, Codable {
        case vsad = "😣"
        case sad = "😞"
        case ok = "😐"
        case good = "😊"
        case vgood = "😄"
    }
}

class EntryStore: ObservableObject {
    @Published var entries = [String: Entry]() // [22-06-2021: Entry]
    
    @Published var graphEntries = [DataPoint]()
    @Published var monthlyGraphEntries = [DataPoint]()
    
    var sortedEntries: [Entry] {
        return entries.values.sorted(by: { $0.date > $1.date })
    }
    
    var sevenEntries: [Entry] {
        if sortedEntries.count < 7 {
            var results: [Entry] = []
            results = sortedEntries
            return results
        } else {
            var results: [Entry] = []
            for i in 0..<7 {
                results.append(sortedEntries[i])
            }
            return results
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    private lazy var weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEE"
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/M"
        return formatter
    }()
    
    private let cacheStorageManager: CacheStorageManager
    
    init() {
        let manager = CacheStorageManager()
        let entries = manager.getEntries()
            
        self.cacheStorageManager = manager
        
        var entriesDict = [String: Entry]()
        for entry in entries {
            entriesDict[dateFormatter.string(from: entry.date)] = entry
        }
        self.entries = entriesDict
        updateChartEntries()
        updateMonthlyChartEntries()
    }
    
    func addEntry(_ entry: Entry) {
        let dateString = dateFormatter.string(from: entry.date)
        entries[dateString] = entry
        updateChartEntries()
        updateMonthlyChartEntries()
        saveEntriesToCache()
    }
    
    func saveEntriesToCache() {
        cacheStorageManager.saveEntries(entries.map(\.value))
    }
    
    private func updateChartEntries() {
        // Find the last 7 days of entries from the array
        let currentDate = Date()
        var dataPoints = [DataPoint]()
        
        for i in 0...6 {
            guard let date = Calendar.current.date(byAdding: .day, value: -(i), to: currentDate) else { continue }
            let dayString = dateFormatter.string(from: date) // 22-06-2021
            let formattedDayString = weekdayFormatter.string(from: date) // Tue
            
            if let entry = entries[dayString] {
                
                let legend: Legend
                if entry.rating < 4 {
                    legend = Legend(color: .pink, label: "")
                } else if  entry.rating < 7 {
                    legend = Legend(color: .purple, label: "")
                } else {
                    legend = Legend(color: .blue, label: "")
                }
                
                let dataPoint = DataPoint(value: entry.rating, label: LocalizedStringKey(formattedDayString), legend: legend)
                dataPoints.insert(dataPoint, at: 0)
            } else {
                let dataPoint = DataPoint(value: 0, label: LocalizedStringKey(formattedDayString), legend: chartLegend)
                dataPoints.insert(dataPoint, at: 0)
            }
        }
        self.graphEntries = dataPoints
    }
    
    private func updateMonthlyChartEntries() {
        // Find the last 30 days of entries from the array
        let currentDate = Date()
        var dataPoints = [DataPoint]()
        
        for i in 0...28 {
            guard let date = Calendar.current.date(byAdding: .day, value: -(i), to: currentDate) else { continue }
            let dayString = dateFormatter.string(from: date) // 22-06-2021
            let formattedDayString = dayFormatter.string(from: date) // 22
            
            if let entry = entries[dayString] {
                
                let legend: Legend
                if entry.rating < 4 {
                    legend = Legend(color: .pink, label: "")
                } else if  entry.rating < 7 {
                    legend = Legend(color: .purple, label: "")
                } else {
                    legend = Legend(color: .blue, label: "")
                }
                
                let dataPoint = DataPoint(value: entry.rating, label: LocalizedStringKey(formattedDayString), legend: legend)
                dataPoints.insert(dataPoint, at: 0)
            } else {
                let dataPoint = DataPoint(value: 0, label: LocalizedStringKey(formattedDayString), legend: chartLegend)
                dataPoints.insert(dataPoint, at: 0)
            }
        }
        self.monthlyGraphEntries = dataPoints
    }

    
    func conseqEntries() -> Int {
        var counter = 0
        let sorted = entries.values.sorted(by: { $0.date > $1.date })
        for value in sorted {
            if Calendar.current.isDate(value.date, inSameDayAs: Calendar.current.date(byAdding: .day, value: (-1 * (counter)) , to: Date())!) {
                counter += 1
            } else {
                break
            }
        }
        return counter
    }
    
//    func noEntryDays() {
//        let sorted = entries.values.sorted(by: { $0.date > $1.date })
//        if Calendar.current.isDate(sorted.first?.date ?? Date(), inSameDayAs: Calendar.current.date(byAdding: .day, value: -3, to: Date())!) {
//            print("Check up triggered")
//        }
//    }
    
    func testNoEntryDays() {
        let sorted = entries.values.sorted(by: { $0.date > $1.date })
        if Calendar.current.isDate(sorted.first?.date ?? Date(), inSameDayAs: Date()) {
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("Check up triggered")
//                        UNNotificationTrigger(coder: <#T##NSCoder#>)
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
        }
    }
    
    
    func average() -> Double {
        if entries.isEmpty {
            return 5
        } else {
            let total = entries.reduce(0) { prev, rating in
                return prev + rating.value.rating
            }
            let average = total / Double(entries.count)
            return average
        }
    }
    
    func todaysEntry() -> Entry? {
        let todayString = dateFormatter.string(from: Date())
        return entries[todayString]
    }
}
