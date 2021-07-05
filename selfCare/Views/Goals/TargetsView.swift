//
//  GoalsView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI
struct TargetsView: View {
    
    @ObservedObject var longTermGoalStore: GoalStore
    @ObservedObject var weeklyGoalStore: GoalStore
    @ObservedObject var dailyGoalStore: GoalStore
    @State private var showNewGoalView = false
    @State var expandedID: String?
    
    var body: some View {
        
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
                                    print("")
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
                
                //Empty goal list placeholder
//                if dailyGoalStore.goals.isEmpty == true && longTermGoalStore.isEmpty == true && weeklyGoalStore.isEmpty == true  {
//                    VStack(alignment: .center) {
//                        Image(systemName: "plus.circle")
//                            .font(.system(size: 200, weight: .regular, design: .default))
//                            .padding(30)
//
//                        Text("When you enter goals they will appear on this screen. It's up to you whether they're short term or long term, or if they should be assigned as daily goals.")
//                            .font(.system(size: 20, weight: .regular, design: .default))
//                            .multilineTextAlignment(.center)
//                            .padding(.horizontal, 60)
//                    }
//                    .opacity(0.4)
//                    .padding(.bottom, 50)
//                }
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
    
    func deleteDaily(at offsets: IndexSet) {
        dailyGoalStore.goals.remove(atOffsets: offsets)
    }
    
    func deleteWeekly(at offsets: IndexSet) {
        weeklyGoalStore.goals.remove(atOffsets: offsets)
    }
    
    func deleteLongTerm(at offsets: IndexSet) {
        longTermGoalStore.goals.remove(atOffsets: offsets)
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
