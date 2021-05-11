//
//  Goals.swift
//  selfCare
//
//  Created by Joseph Taylor on 11/05/2021.
//

import Foundation

struct Goal: Identifiable {
    
//    enum importance: Int {
//        case low = 1
//        case high = 2
//        case daily = 3
//    }
    
    var id: String
    let goalText: String
    let completed: Bool
    //let importance:
}

class GoalStore: ObservableObject {
    @Published var goals = [Goal]()
    
    func addGoal(_ goal: Goal) {
        goals.append(goal)
    }
}
