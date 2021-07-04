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
    @State var targetType: String = "Daily"
    
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
                
                //Target Title
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                        .padding(.horizontal, 10)
                    VStack(alignment: .leading) {
                        Text("What's your target?")
                            .fontWeight(.bold)
                            .foregroundColor(Color("TextColor"))
                            .padding()
                        
                        ZStack(alignment: .leading) {
                            TextViewWrapper(text: $titleText)
                                .frame(width: 360, height: 40, alignment: .center)
                                .cornerRadius(10)
                                .padding(.horizontal, 10)
                            if titleText.isEmpty {
                                Text("My target today is...")
                                    .opacity(0.4)
                                    .padding(.all, 20)
                            }
                        }
                    }
                }
                .padding(.bottom, 10)
                
                //Target Type
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("ModeColor"))
                        .padding(.horizontal, 10)
                        .applyShadow()
    
                    VStack(alignment: .leading) {
                        Text("Target Type:")
                            .fontWeight(.bold)
                            .foregroundColor(Color("TextColor"))
                            .padding()
                            .padding(.horizontal, 10)
                        
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.blue)
                                    .opacity(targetType == "Daily" ? 1 : 0.5)
                                    .applyShadow()
                                Button(action: {
                                    targetType = "Daily"
                                }, label: {
                                    Text("Daily")
                                        .applyButtonModifier()
                                })
                            }
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.purple)
                                    .opacity(targetType == "Weekly" ? 1 : 0.5)
                                    .applyShadow()
                                Button(action: {
                                    targetType = "Weekly"
                                }, label: {
                                    Text("Weekly")
                                        .applyButtonModifier()
                                        .padding()
                                        .cornerRadius(15)
                                })
                            }
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.pink)
                                    .opacity(targetType == "Long Term" ? 1 : 0.5)
                                    .applyShadow()
                                Button(action: {
                                    targetType = "Long Term"
                                }, label: {
                                    Text("Long Term")
                                        .applyButtonModifier()
                                })
                            }
                        }
                        .padding(.bottom, 10)
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 10)
                
                //Target description
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                        .padding(.horizontal, 10)
                        
                    VStack(alignment: .leading) {
                        Text("Description:")
                            .fontWeight(.bold)
                            .foregroundColor(Color("TextColor"))
                            .padding()
                            .padding(.horizontal, 10)
                        
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
                .padding(.bottom, 10)
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

struct buttonModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(Color("TextColor"))
            .cornerRadius(15)
    }
}

extension View {
    func applyButtonModifier() -> some View {
        return self.modifier(buttonModifier())
    }
}
