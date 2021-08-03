//
//  Reminders.swift
//  selfCare
//
//  Created by Joseph Taylor on 12/07/2021.
//

import SwiftUI
import UserNotifications

struct Reminder: View {
    
    @Binding var targetTime: Date
    @Binding var journalTime: Date
    
    @ObservedObject var profileStore: ProfileStore
    @State var isTargetsExpanded: Bool
    @State var isJournalExpanded: Bool
    
    var body: some View {
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color("ModeColor"))
                    .applyShadow()
                
                VStack {
                    if isTargetsExpanded == false {
                        HStack {
                            Text("Targets Reminder:")
                                .applyMiddleTitleStyle()
                            Text(profileStore.dateConverter(input: targetTime))
                                .applyMiddleTitleStyle()
                        }
                        .padding(.vertical, 20)
                        
                        .onTapGesture {
                            if isTargetsExpanded == true {
                                isTargetsExpanded = false
                            } else {
                                isTargetsExpanded = true
                            }
                        }
                    }
                    
                    
                    if isTargetsExpanded == true {
                        VStack {
                            HStack {
                                Text("Targets Reminder:")
                                    .applyMiddleTitleStyle()
                                DatePicker("", selection: $targetTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                            }
                            
                            HStack {
                                Button(action: {
                                    isTargetsExpanded = false
                                    
                                }, label: {
                                    Text("Cancel")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 30)
                                        .padding(10)
                                        .background(Color.pink)
                                        .cornerRadius(10)
                                })
                                Button(action: {
                                    isTargetsExpanded = false
                                    
                                    
                                }, label: {
                                    Text("Done")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 30)
                                        .padding(10)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .purple]), startPoint: .leading, endPoint: .trailing))
                                        .cornerRadius(10)
                                })
                            }
                        }
                        .padding()
                    }
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color("ModeColor"))
                    .applyShadow()
                
                VStack {
                    if isJournalExpanded == false {
                        HStack {
                            Text("Targets Reminder:")
                                .applyMiddleTitleStyle()
                            Text(profileStore.dateConverter(input: journalTime))
                                .applyMiddleTitleStyle()
                        }
                        .padding(.vertical, 20)
                        
                        .onTapGesture {
                            if isJournalExpanded == true {
                                isJournalExpanded = false
                            } else {
                                isJournalExpanded = true
                            }
                        }
                    }
                    
                    
                    if isJournalExpanded == true {
                        VStack {
                            HStack {
                                Text("Targets Reminder:")
                                    .applyMiddleTitleStyle()
                                DatePicker("", selection: $journalTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                            }
                            
                            HStack {
                                Button(action: {
                                    isJournalExpanded = false
                                    
                                }, label: {
                                    Text("Cancel")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 30)
                                        .padding(10)
                                        .background(Color.pink)
                                        .cornerRadius(10)
                                })
                                Button(action: {
                                    isTargetsExpanded = false
                                    
                                    
                                }, label: {
                                    Text("Done")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 30)
                                        .padding(10)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .purple]), startPoint: .leading, endPoint: .trailing))
                                        .cornerRadius(10)
                                })
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}


