//
//  Profile.swift
//  selfCare
//
//  Created by Joseph Taylor on 24/06/2021.
//

import SwiftUI

struct Profile: Codable {
    let profilePicture: Data
    var name: String
    let targetTime: Date?
    let journalTime: Date?
    let targetTimeText: String
    let journalTimeText: String
}

class ProfileStore: ObservableObject {
    @Published var profile: Profile?

    private let cacheStorageManager: CacheStorageManager

    init() {
        let manager = CacheStorageManager()
        let profile = manager.getProfile()

        self.cacheStorageManager = manager
        self.profile = profile
    }

    func updateProfile(_ profile: Profile) {
        self.profile = profile
        saveProfileToCache()
    }
    
    private func saveProfileToCache() {
        if let profile = profile {
            cacheStorageManager.saveProfile(profile)
        } else {
            cacheStorageManager.removeProfile()
        }
    }
    
    var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    func updateJournalReminder(input: Date) -> String {
        return timeFormatter.string(from: input)
    }

    
    func updateTargetReminder(input: Date) -> String {
        return timeFormatter.string(from: input)
    }
}
