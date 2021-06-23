//
//  Goals.swift
//  selfCare
//
//  Created by Joseph Taylor on 11/05/2021.
//

import Foundation

struct Goal: Identifiable {
    
    var id: String
    let title: String
    let goalText: String
    let completed: Bool
}

class GoalStore: ObservableObject {
    @Published var goals = [Goal]()
    
    func addGoal(_ goal: Goal) {
        goals.append(goal)
    }
}
