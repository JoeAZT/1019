//
//  GoalsView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI
struct TargetsView: View {
    
    @ObservedObject var goalStore: GoalStore
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
                        ForEach(goalStore.goals) { goal in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 380, height: expandedID == goal.id ? 200 : 50, alignment: .center)
                                    .foregroundColor(Color("ModeColor"))
                                    .applyShadow()
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(goal.title)
                                            .foregroundColor(goal.completed ? Color.gray : Color("TextColor"))
                                            .fontWeight(.bold)
                                            .padding(.vertical, 10)
                                        if expandedID == goal.id {
                                            Text(goal.goalText)
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                    Spacer()
                                    Image(systemName: goal.completed ? "checkmark.square" : "square")
                                        .font(.system(size: 30, weight: .bold, design: .default))
                                        .onTapGesture {
                                            goalStore.toggleCompletedFor(goal)
                                        }
                                }
                                .padding(8)
                                .padding(.horizontal, 5)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if self.expandedID == goal.id {
                                    self.expandedID = nil
                                } else {
                                    self.expandedID = goal.id
                                }
                            }
                            .animation(.spring())
                        }
                        .onDelete(perform: delete)
                    }
                    .padding(.leading, -3)
                    
                    
                    //Empty goal list placeholder
                    if goalStore.goals.isEmpty {
                        VStack {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 200, weight: .regular, design: .default))
                                .padding(30)
                            
                            Text("When you enter goals they will appear on this screen. It's up to you whether they're short term or long term, or if they should be assigned as daily goals.")
                                .font(.system(size: 20, weight: .regular, design: .default))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 60)
                            
                        }
                        .opacity(0.4)
                        .padding(.bottom, 50)
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
                    NewTargetView(showGoalView: $showNewGoalView, goalStore: goalStore)
                }
            }
        }
    }
    
    
    
    func delete(at offsets: IndexSet) {
        goalStore.goals.remove(atOffsets: offsets)
    }
}


struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
