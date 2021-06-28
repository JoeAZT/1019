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
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                        .padding(.horizontal, 10)
                    VStack {
                        Text("What's your target?")
                            .fontWeight(.bold)
                            .foregroundColor(Color("TextColor"))
                            .applyShadow()
                            .padding()
                            .padding(.trailing, 200)
                        
                        ZStack {
                            TextViewWrapper(text: $titleText)
                                .frame(width: 360, height: 40, alignment: .center)
                                .cornerRadius(10)
//                                .padding()
                                .padding(.horizontal, 10)
                            if titleText.isEmpty {
                                Text("My target today is...")
                                    .opacity(0.4)
                                    .padding(.all, 20)
                                    .padding(.trailing, 200)
                            }
                        }
                    }
                }
                .padding(.bottom, 10)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                        .padding(.horizontal, 10)
                    VStack {
                        Text("Description:")
                            .fontWeight(.bold)
                            .foregroundColor(Color("TextColor"))
                            .applyShadow()
                            .padding()
                            .padding(.trailing, 255)
                        
                        ZStack(alignment: .topLeading) {
                            TextViewWrapper(text: $goalText)
                                .frame(width: 360, height: 400, alignment: .center)
                                .cornerRadius(10)
                                .padding()
                                .padding(.horizontal, 10)
                            if goalText.isEmpty {
                                Text("Tell me more abut your target...")
                                    .opacity(0.4)
                                    .padding(.all, 25)
                                    .padding(.leading, 8)
                            }
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

