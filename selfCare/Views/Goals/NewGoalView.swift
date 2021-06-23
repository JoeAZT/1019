//
//  NewGoalView.swift
//  selfCare
//
//  Created by Joseph Taylor on 11/05/2021.
//

import SwiftUI

struct NewGoalView: View {
    
    @State var goalText: String = ""
    @State var titleText: String = ""
    @Binding var showGoalView: Bool
    @ObservedObject var goalStore: GoalStore
    
    var body: some View {
        
        VStack {
            
            //Screen Title
            Text("New Goal")
                .fontWeight(.semibold)
                .foregroundColor(Color("TextColor"))
                .font(.title)
                .padding()
                .padding(.bottom, 10)
            
            ScrollView {
    
                VStack() {
                    
                    Text("What's your goal?")
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
                            Text("My goal today is...")
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
                            Text("Tell me more abut your goal...")
                                .opacity(0.4)
                                .padding(.all, 25)
                                .padding(.trailing, 110)
                        }
                    }
                }
            }
        }
            Button(action: {
                print("Complete Entry")
                
                self.showGoalView = false
                let goal = Goal(id: UUID().uuidString, title: titleText, goalText: goalText, completed: false)
                goalStore.addGoal(goal)
                
                //CacheStorageManager.shared.saveEntries()
            
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

