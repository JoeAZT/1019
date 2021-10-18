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
    
    let onTapSaveTargetTime: () -> Void
    let onTapSaveJournalTime: () -> Void
    
    var body: some View {
        
        VStack {
            VStack {
                if isTargetsExpanded == false {
                    HStack {
                        Text("Targets Reminder:")
                            .applyTopTitleStyle()
                        Spacer()
                        Text(profileStore.dateConverter(input: targetTime))
                            .applyMiddleTitleStyle()
                    }
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
                                .applyTopTitleStyle()
                            Spacer()
                            Button(action: {
                                isTargetsExpanded = false
                                
                            }, label: {
                                Image(systemName: "multiply.square.fill")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(Color.purple)
                            })
                            Button(action: {
                                isTargetsExpanded = false
                                
                                onTapSaveTargetTime()
                            }, label: {
                                Image(systemName: "checkmark.square.fill")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(Color.green)
                            })
                            DatePicker("", selection: $targetTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                    }
                }
            }.foregroundColor(Color("ModeColor"))
            
            VStack {
                if isJournalExpanded == false {
                    HStack {
                        Text("Targets Reminder:")
                            .applyTopTitleStyle()
                        Spacer()
                        Text(profileStore.dateConverter(input: journalTime))
                            .applyMiddleTitleStyle()
                    }
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
                                .applyTopTitleStyle()
                            Spacer()
                            Button(action: {
                                isJournalExpanded = false
                                
                            }, label: {
                                Image(systemName: "multiply.square.fill")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(Color.purple)
                            })
                            Button(action: {
                                isJournalExpanded = false
                                
                                onTapSaveJournalTime()
                            }, label: {
                                Image(systemName: "checkmark.square.fill")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(Color.green)
                            })
                            DatePicker("", selection: $journalTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                    }
                }
            }.foregroundColor(Color("ModeColor"))
        }
        .padding(.horizontal, 30)
    }
}


