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
            
            if let time = profile.targetTime {
                scheduleNotificationForTarget(time)
            }
        } else {
            cacheStorageManager.removeProfile()
        }
        if let time = profile?.journalTime {
            scheduleNotificationForJournal(time)
        } else {
            cacheStorageManager.removeProfile()
        }
    }
    
    private func scheduleNotificationForTarget(_ date: Date) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set 1")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        
        let content = UNMutableNotificationContent()
        content.title = "Targets"
        content.subtitle = "It's time to fill in your targets for today."
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        UNUserNotificationCenter.current().add(.init(identifier: "TargetTime", content: content, trigger: trigger))
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func scheduleNotificationForJournal(_ date: Date) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set 1")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        
        let content = UNMutableNotificationContent()
        content.title = "Journal"
        content.subtitle = "It's time to fill in your journal for today."
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        UNUserNotificationCenter.current().add(.init(identifier: "JournalTime", content: content, trigger: trigger))
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    func dateConverter(input: Date) -> String {
        return timeFormatter.string(from: input)
    }
    
    
    
}
