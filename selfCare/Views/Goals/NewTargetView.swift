//
//  NewGoalView.swift
//  selfCare
//
//  Created by Joseph Taylor on 11/05/2021.
//

import SwiftUI

struct NewTargetView: View {
    
    @State var goalText: String = ""
    @State var titleText: String = ""
    @Binding var showGoalView: Bool
    @ObservedObject var goalStore: GoalStore
    @State var isCompleted: Bool = false
    
    var body: some View {
        
        VStack {
            //Screen Title
            Text("New Target")
                .fontWeight(.semibold)
                .foregroundColor(Color("TextColor"))
                .font(.title)
                .padding()
                .padding(.bottom, 10)
            
            ScrollView {
    
                VStack() {
                    
                    Text("What's your target?")
                        .fontWeight(.bold)
                        .frame(width: 370, height: 25, alignment: .leading)
                        .foregroundColor(Color("TextColor"))
                        .padding()

                    ZStack(alignment: .topLeading) {
                        TextViewWrapper(text: $titleText)
                            .frame(width: 340, height: 25, alignment: .center)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color("TextColor"), lineWidth: 4))
                            .padding(.bottom, 10)
                        if titleText.isEmpty {
                            Text("My target today is...")
                                .opacity(0.4)
                                .padding(.all, 20)
                                .padding(.trailing, 110)
                        }
                    }
                    .padding(.trailing, 10)
                    
                    Text("Description:")
                        .fontWeight(.bold)
                        .frame(width: 370, height: 20, alignment: .leading)
                        .foregroundColor(Color("TextColor"))
                        .padding()
                    
                    ZStack(alignment: .topLeading) {
                        TextViewWrapper(text: $goalText)
                            .frame(width: 340, height: 300, alignment: .center)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color("TextColor"), lineWidth: 4))
                            .padding(.bottom, 10)
                        if goalText.isEmpty {
                            Text("Tell me more abut your target...")
                                .opacity(0.4)
                                .padding(.all, 25)
                                .padding(.trailing, 110)
                        }
                    }
                }
            }
        }
            Button(action: {
                self.showGoalView = false
                let goal = Goal(id: UUID().uuidString, title: titleText, goalText: goalText, completed: false)
                goalStore.addGoal(goal)
            
            }, label: {
                Text("Complete Entry")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .pink]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(15)
            })
        }
    }

