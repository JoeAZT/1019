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
            Text("Goals")
                .fontWeight(.semibold)
                .foregroundColor(Color("TextColor"))
                .font(.title)
                .padding()
            
            VStack {
                
                ZStack {
                    //List of goals
                    List {
                        ForEach(goalStore.goals) { goal in
                                VStack(alignment: .center) {
                                    Text(goal.title)
                                }
                                .frame(width: 350, height: 40, alignment: .leading)
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("TextColor"), lineWidth: 4))
                                .padding(5)
                        }
                    }
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
