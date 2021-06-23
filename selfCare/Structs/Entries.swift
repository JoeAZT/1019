//
//  EntryStruct.swift
//  selfCare
//
//  Created by Joseph Taylor on 08/05/2021.
//

import Foundation
import SwiftUI
import SwiftUICharts

struct Entry: Identifiable, Codable {
    let id: String
    let rating: Double
    let reflectionText: String
    let happyText: String
    let mood: Mood
    let date: Date
    
    
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
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    private lazy var weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    func addEntry(_ entry: Entry) {
        let dateString = dateFormatter.string(from: entry.date)
        entries[dateString] = entry
        updateChartEntries()
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
                let dataPoint = DataPoint(value: entry.rating, label: LocalizedStringKey(formattedDayString), legend: chartLegend)
                dataPoints.insert(dataPoint, at: 0)
            } else {
                let dataPoint = DataPoint(value: 0, label: LocalizedStringKey(formattedDayString), legend: chartLegend)
                dataPoints.insert(dataPoint, at: 0)
            }
        }
        self.graphEntries = dataPoints
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
}
