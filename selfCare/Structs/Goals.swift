//
//  Goals.swift
//  selfCare
//
//  Created by Joseph Taylor on 11/05/2021.
//

import Foundation

struct Goal: Identifiable, Codable {
    let id: String
    let title: String
    let goalText: String
    var completed: Bool
    var targetType: TargetType

    enum TargetType: String, Codable {
        case daily, weekly, longTerm
    }
}

class GoalStore: ObservableObject {
    @Published var goals = [Goal]()
    
    private let cacheStorageManager: CacheStorageManager
    
    init() {
        let manager = CacheStorageManager()
        let goals = manager.getGoals()
        
        self.cacheStorageManager = manager
        self.goals = goals
    }
    
    func addGoal(_ goal: Goal) {
        goals.append(goal)
        saveGoalsToCache()
    }
    
    func toggleCompletedFor(_ goal: Goal) {
        var goal = goal
        goal.completed = !goal.completed
        goals.removeAll(where: { $0.id == goal.id })
        goals.append(goal)
        saveGoalsToCache()
    }
    
    private func saveGoalsToCache() {
        cacheStorageManager.saveGoals(goals)
    }
    
}
