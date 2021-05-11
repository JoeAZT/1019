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
                
                List {
                    ForEach(goalStore.goals) { goal in
                            VStack(alignment: .leading) {

                                Text(goal.goalText)
                            }
                            .frame(width: 220, height: 80, alignment: .leading)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color("TextColor"), lineWidth: 4))
                            .padding(5)
                            
                    }
                }
                Button(action: {
                    print("Create Goal Screen")
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
