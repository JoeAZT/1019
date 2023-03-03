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
            //                .opacity(0.2)
            TabView {
                VStack(alignment: .leading) {
                    Text("Your daily targets:")
                        .font(.system(size: 20, weight: .bold, design: .default))
                    //                        .foregroundColor(.white)
                        .foregroundColor(Color("TextColor"))
                    
                    ScrollView {
                        ForEach(dailyGoalStore.goals) { goal in
                                HStack {
                                    Text(goal.title)
                                        .fontWeight(.semibold)
                                    //                                        .foregroundColor(.white)
                                        .foregroundColor(Color("TextColor"))
                                        .padding(5)
                                    Spacer()
                                    Image(systemName: goal.completed ? "checkmark.square" : "square")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                    //                                        .foregroundColor(.white)
                                        .foregroundColor(Color("TextColor"))
                                        .padding(5)
                                }
                                .background(Color("ModeColor"))
                                .cornerRadius(10)
                                .shadow(color: Color("TextColor").opacity(0.2), radius: 3, x: 2, y: 2)
                                .padding(.horizontal, 4)
                                .onTapGesture {
                                    dailyGoalStore.toggleCompletedFor(goal)
                                }
                        }
                    }
                }
                .padding()
                .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    Text("Your weekly targets:")
                        .font(.system(size: 20, weight: .bold, design: .default))
                    //                        .foregroundColor(.white)
                        .foregroundColor(Color("TextColor"))
                    
                    ScrollView {
                        ForEach(weeklyGoalStore.goals) { goal in
                            HStack {
                                Text(goal.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("TextColor"))
                                    .padding(5)
                                Spacer()
                                Image(systemName: goal.completed ? "checkmark.square" : "square")
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                    .foregroundColor(Color("TextColor"))
                                    .padding(5)
                            }
                            .background(Color("ModeColor"))
                            .cornerRadius(10)
                            .shadow(color: Color("TextColor").opacity(0.2), radius: 3, x: 2, y: 2)
                            .padding(.horizontal, 4)
                            .onTapGesture {
                                weeklyGoalStore.toggleCompletedFor(goal)
                            }
                        }
                    }
                }
                .padding()
            }.tabViewStyle(PageTabViewStyle())
        }
    }
}
