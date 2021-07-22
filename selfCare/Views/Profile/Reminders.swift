//
//  Reminders.swift
//  selfCare
//
//  Created by Joseph Taylor on 12/07/2021.
//

import SwiftUI

struct Reminder: View {
    
    @State var targetTime: Date
    @State var journalTime: Date
    @ObservedObject var profileStore: ProfileStore
    @State var isExpanded = false
    
    var body: some View {
        
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color("ModeColor"))
                    .applyShadow()
                VStack {
                    Text("Targets Reminder:")
                        .applyMiddleTitleStyle()
                    if isExpanded == false {
                        Text(profileStore.updateTargetReminder(input: targetTime))
                        .font(.system(size: 30, weight: .bold))
                        .padding(.top, 10)
                        .onTapGesture {
                            if isExpanded == true {
                                isExpanded = false
                            } else {
                                isExpanded = true
                            }
                        }
                        
                    } else {
                    DatePicker("", selection: $targetTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .padding()
                        
                        HStack {
                            Button(action: {
                                isExpanded = false
                                // This button should have the functionality to save the time specified by the user
                            }, label: {
                                Text("Cancel")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.pink)
                                    .cornerRadius(15)
                            })
                            Button(action: {
                                isExpanded = false
                            }, label: {
                                Text("Done")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .purple]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(15)
                            })
                        }
                    }
                }
                .padding()
            }
            .padding(5)
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color("ModeColor"))
                    .applyShadow()
                VStack {
                    Text("Jounral Reminder:")
                        .applyMiddleTitleStyle()
                    if isExpanded == false {
                    Text(profileStore.updateJournalReminder(input: journalTime))
                        .font(.system(size: 30, weight: .bold))
                        .padding(.top, 10)
                        .onTapGesture {
                            if isExpanded == true {
                                isExpanded = false
                            } else {
                                isExpanded = true
                            }
                        }
                    } else {
                    DatePicker("", selection: $journalTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .padding()
                        HStack {
                            Button(action: {
                                isExpanded = false
                                
                            }, label: {
                                Text("Cancel")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.pink)
                                    .cornerRadius(15)
                            })
                            Button(action: {
                                isExpanded = false
                                // This button should have the functionality to save the time specified by the user
                            }, label: {
                                Text("Done")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .purple]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(15)
                            })
                        }
                    }
                }
                .padding()
            }
            .padding(5)
        }
    }
}


