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
    let targetReminder: Date
    let journalReminder: Date
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
}
