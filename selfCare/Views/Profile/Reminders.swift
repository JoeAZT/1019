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
        
        VStack(spacing: 8) {
            VStack {
                if isTargetsExpanded == false {
                    HStack {
                        Text("Targets Reminder:")
                            .bold()
                        Spacer()
                        Text(profileStore.dateConverter(input: targetTime))
                            .applyMiddleTitleStyle()
                            .foregroundColor(Color("ModeColor"))
                            .padding(7)
                            .background(Color("TextColor"))
                            .cornerRadius(10)
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
                                .bold()
                            Spacer()
                            Button(action: {
                                isTargetsExpanded = false
                                
                            }, label: {
                                Image(systemName: "multiply.square.fill")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(.pink)
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
            }.foregroundColor(Color("TextColor"))
            
            VStack {
                if isJournalExpanded == false {
                    HStack {
                        Text("Journal Reminder:")
                            .bold()
                        Spacer()
                        Text(profileStore.dateConverter(input: journalTime))
                            .applyMiddleTitleStyle()
                            .foregroundColor(Color("ModeColor"))
                            .padding(7)
                            .background(Color("TextColor"))
                            .cornerRadius(10)
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
                            Text("Journal Reminder:")
                                .bold()
                            Spacer()
                            Button(action: {
                                isJournalExpanded = false
                                
                            }, label: {
                                Image(systemName: "multiply.square.fill")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(.pink)
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
            }
        }
    }
}


