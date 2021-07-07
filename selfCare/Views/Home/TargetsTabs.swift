//
//  TargetsTabs.swift
//  selfCare
//
//  Created by Joseph Taylor on 07/07/2021.
//

import SwiftUI

struct TargetTabs: View {
    
    @ObservedObject var dailyGoalStore = DailyGoalStore()
    @ObservedObject var weeklyGoalStore = WeeklyGoalStore()
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("ModeColor"))
                .opacity(0.2)
            TabView {
                VStack(alignment: .leading) {
                    Text("Your daily targets:")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                    ScrollView {
                        ForEach(dailyGoalStore.goals) { goal in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(Color("ModeColor"))
                                    .opacity(0.1)
                                HStack {
                                    Text(goal.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .padding(5)
                                    Spacer()
                                    Image(systemName: goal.completed ? "checkmark.square" : "square")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                        .padding(5)
                                }
                                .onTapGesture {
                                    dailyGoalStore.toggleCompletedFor(goal)
                                }
                            }
                        }
                    }
                }
                .padding()
                .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    Text("Your weekly targets:")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                    ScrollView {
                        ForEach(weeklyGoalStore.goals) { goal in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(Color("ModeColor"))
                                    .opacity(0.1)
                                HStack {
                                    Text(goal.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .padding(5)
                                    Spacer()
                                    Image(systemName: goal.completed ? "checkmark.square" : "square")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                        .padding(5)
                                }
                                .onTapGesture {
                                    weeklyGoalStore.toggleCompletedFor(goal)
                                }
                            }
                        }
                        
                    }
                }
                .padding()
                .padding(.horizontal, 10)
            }.tabViewStyle(PageTabViewStyle())
        }.frame(height: 200)
    }
    
}
