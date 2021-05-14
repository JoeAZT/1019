//
//  EntryStruct.swift
//  selfCare
//
//  Created by Joseph Taylor on 08/05/2021.
//

import Foundation

struct Entry: Identifiable, Codable {
    let id: String
    let rating: Double
    let reflectionText: String
    let happyText: String
}

class EntryStore: ObservableObject {
    @Published var entries = [Entry]()
    
    func addEntry(_ entry: Entry) {
        entries.append(entry)
    }
}
