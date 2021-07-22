//
//  GoalsView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI
import IrregularGradient
struct TargetsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isDarkMode") private var isDarkMode = false
    @ObservedObject var longTermGoalStore: LongTermGoalStore
    @ObservedObject var weeklyGoalStore: WeeklyGoalStore
    @ObservedObject var dailyGoalStore: DailyGoalStore
    @State private var showNewGoalView = false
    @State var expandedID: String?
    
    var body: some View {
        
        //Consider using a nav view instead of using the Text() option at the top of the screens? Look into is at least.
        
        //Empty goal list placeholder
        if dailyGoalStore.goals.isEmpty == true && weeklyGoalStore.goals.isEmpty == true && longTermGoalStore.goals.isEmpty == true {
            VStack {
                    Text("Targets")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("TextColor"))
                        .font(.title)
                        .padding()
                
                Spacer()
                
                VStack {
                Image(systemName: "plus.circle")
                    .font(.system(size: 200, weight: .regular, design: .default))
                
                Text("When you enter targets they will appear on this screen. It's up to you whether they're daily, weekly, or if they should be assigned as long term targets.")
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 30)
            .opacity(0.4)
                
                Spacer()
            
                Button(action: {
                    showNewGoalView.toggle()
                    
                }, label: {
                    Text("Create Goal")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .pink]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(15)
                })
                .sheet(isPresented: $showNewGoalView) {
                    NewTargetView(showGoalView: $showNewGoalView, longTermGoallStore: longTermGoalStore, dailyGoalStore: dailyGoalStore, weeklyGoalStore: weeklyGoalStore)
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        } else {
            VStack {
                Text("Targets")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TextColor"))
                    .font(.title)
                    .padding()
                
                VStack {
                    ZStack {
                        //List of goals
                        List {
                            Section(header: Text("Daily")) {
                                ForEach(dailyGoalStore.goals) { goal in
                                    TargetRow(goal: goal, isExpanded: expandedID == goal.id) {
                                        dailyGoalStore.toggleCompletedFor(goal)
                                    }
                                    .onTapGesture {
                                        if self.expandedID == goal.id {
                                            self.expandedID = nil
                                        } else {
                                            self.expandedID = goal.id
                                        }
                                    }
                                    .animation(.spring())
                                }
                                .onDelete(perform: deleteDaily)
                            }
                            Section(header: Text("Weekly")) {
                                ForEach(weeklyGoalStore.goals) { goal in
                                    TargetRow(goal: goal, isExpanded: expandedID == goal.id) {
                                        weeklyGoalStore.toggleCompletedFor(goal)
                                    }
                                    .onTapGesture {
                                        if self.expandedID == goal.id {
                                            self.expandedID = nil
                                        } else {
                                            self.expandedID = goal.id
                                        }
                                    }
                                    .animation(.spring())
                                }
                                .onDelete(perform: deleteWeekly)
                            }
                            Section(header: Text("Long Term")) {
                                ForEach(longTermGoalStore.goals) { goal in
                                    TargetRow(goal: goal, isExpanded: expandedID == goal.id) {
                                        longTermGoalStore.toggleCompletedFor(goal)
                                    }
                                    .onTapGesture {
                                        if self.expandedID == goal.id {
                                            self.expandedID = nil
                                        } else {
                                            self.expandedID = goal.id
                                        }
                                    }
                                    .animation(.spring())
                                }
                                .onDelete(perform: deleteLongTerm)
                            }
                        }
                    }
                    Button(action: {
                        showNewGoalView.toggle()
                        
                    }, label: {
                        Text("Create Goal")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .pink]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(15)
                    })
                    .sheet(isPresented: $showNewGoalView) {
                        NewTargetView(showGoalView: $showNewGoalView, longTermGoallStore: longTermGoalStore, dailyGoalStore: dailyGoalStore, weeklyGoalStore: weeklyGoalStore)
                    }
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
    
    
    func deleteDaily(at offsets: IndexSet) {
        dailyGoalStore.goals.remove(atOffsets: offsets)
        dailyGoalStore.saveGoalsToCache()
    }
    
    func deleteWeekly(at offsets: IndexSet) {
        weeklyGoalStore.goals.remove(atOffsets: offsets)
        weeklyGoalStore.saveGoalsToCache()
    }
    
    func deleteLongTerm(at offsets: IndexSet) {
        longTermGoalStore.goals.remove(atOffsets: offsets)
        longTermGoalStore.saveGoalsToCache()
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
