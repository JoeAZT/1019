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
    
    var isExpanded: Bool = false
    
    var body: some View {
        
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color("ModeColor"))
                    .applyShadow()
                VStack {
                    Text("Targets Reminder:")
                        .applyMiddleTitleStyle()
                    Text(profileStore.updateTargetReminder(input: targetTime))
                    if isExpanded == true {
                    DatePicker("", selection: $targetTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .padding()
                    }
                }
                .padding()
            }
            .padding(5)
            .onTapGesture {
                isExpanded == true ? false : true
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color("ModeColor"))
                    .applyShadow()
                VStack {
                    Text("Jounral Reminder:")
                        .applyMiddleTitleStyle()
                    Text(profileStore.updateJournalReminder(input: journalTime))
                    DatePicker("", selection: $journalTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .padding()
                }
                .padding()
            }
            .padding(5)
        }
    }
}


