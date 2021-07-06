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
        
        VStack {
            HStack {
                Button(action: {
                    longTermGoalStore.saveGoalsToCache()
                    weeklyGoalStore.saveGoalsToCache()
                    dailyGoalStore.saveGoalsToCache()
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                    }
                ,label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .padding()
                        .font(.system(size: 30))
                        .foregroundColor(Color("TextColor"))
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                })
                Spacer()
                
                Text("Targets")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TextColor"))
                    .font(.title)
                    .padding()
                
                Spacer()
                
                Text("Sp")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TextColor"))
                    .font(.title)
                    .padding()
                    .opacity(0.0)
            }
            
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
            .preferredColorScheme(isDarkMode ? .dark : .light)
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
