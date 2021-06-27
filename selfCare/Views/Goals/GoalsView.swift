//
//  GoalsView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI

struct GoalsView: View {
    
    @ObservedObject var goalStore: GoalStore
    @State private var showNewGoalView = false
    
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
                                    .frame(width: 380, height: 50, alignment: .center)
                                    .foregroundColor(Color("ModeColor"))
                                    .applyShadow()
                            HStack {
                                Text(goal.title)
                                    .foregroundColor(goal.completed ? Color.gray : Color("TextColor"))
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName: goal.completed ? "checkmark.square" : "square")
                                    .font(.system(size: 30, weight: .bold, design: .default))
                                    .onTapGesture {
                                        goalStore.toggleCompletedFor(goal)
                                    }
                            }
                            .frame(width: 360, height: 40, alignment: .leading)
                            .padding(8)
                            .padding(.horizontal, 5)
                            }
                        }
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
                    NewGoalView(showGoalView: $showNewGoalView, goalStore: goalStore)
                }
            }
        }
    }
}


struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
