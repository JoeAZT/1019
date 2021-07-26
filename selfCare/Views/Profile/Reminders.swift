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
    @State var isExpanded: Bool
    
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
                        Text(profileStore.dateConverter(input: targetTime))
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
                        Text(profileStore.dateConverter(input: journalTime))
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
                                UNUserNotificationCenter.current()
                                    .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                        if success {
                                            print("All set")
                                        } else if let error = error {
                                            print(error.localizedDescription)
                                        }
                                    }
                                let content = UNMutableNotificationContent()
                                content.title = "Journal"
                                content.subtitle = "It's time for you to complete todays journal entry."
                                content.sound = UNNotificationSound.default
                                
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


