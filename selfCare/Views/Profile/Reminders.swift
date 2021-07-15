//
//  Reminders.swift
//  selfCare
//
//  Created by Joseph Taylor on 12/07/2021.
//

import SwiftUI

struct Reminder: View {
    
    @State var goalTime = Date()
    @State var journalTime = Date()
    @State var targetReminderToggle = true
    @State var journalReminderToggle = true
    
    var body: some View {
        
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color("ModeColor"))
                    .applyShadow()
                VStack {
                Text("Targets Reminder:")
                    .applyMiddleTitleStyle()
                    DatePicker("", selection: $goalTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .padding()
                    Toggle("", isOn: $targetReminderToggle)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
                .padding()
            }
            .padding(5)
            .onTapGesture {
                
            }
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color("ModeColor"))
                    .applyShadow()
                VStack {
                Text("Jounral Reminder:")
                    .applyMiddleTitleStyle()
                    DatePicker("", selection: $journalTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                        .padding()
                    Toggle("", isOn: $journalReminderToggle)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
                .padding()
            }
            .padding(5)
        }
        
    }
    
}
