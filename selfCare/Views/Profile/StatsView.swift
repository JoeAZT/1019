//
//  NameAndProfile.swift
//  selfCare
//
//  Created by Joseph Taylor on 29/08/2021.
//

import SwiftUI

struct StatsView: View {
    
    @Binding var targetTime: Date
    @Binding var journalTime: Date
    @ObservedObject var profileStore: ProfileStore
    @ObservedObject var entryStore: EntryStore
    @ObservedObject var longTermGoalStore: LongTermGoalStore
    @ObservedObject var dailyGoalStore: DailyGoalStore
    @ObservedObject var weeklyGoalStore: WeeklyGoalStore
    
    let onTapSaveTargetTime: () -> Void
    let onTapSaveJournalTime: () -> Void
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("ModeColor"))
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: -5)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Text("""
                            Consecutive
                            Entries:
                            """)
                            .applyAntiTopTitleStyle()
                        Text(String(entryStore.conseqEntries()))
                            .font(.system(size: 40, weight: .semibold, design: .default))
                    }
                    Spacer()
                    VStack {
                        Text("""
                            Journal
                            Entries:
                            """)
                            .applyAntiTopTitleStyle()
                        Text("\(entryStore.entries.count)")
                            .font(.system(size: 40, weight: .semibold, design: .default))
                    }
                    Spacer()
                    VStack {
                        Text("""
                            Goals
                            Completed:
                            """)
                            .applyAntiTopTitleStyle()
                        let totalTargetCount = longTermGoalStore.goals.count + dailyGoalStore.goals.count + weeklyGoalStore.goals.count
                        Text("\(totalTargetCount)")
                            .font(.system(size: 40, weight: .semibold, design: .default))
                    }
                    Spacer()
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 3)
                    .foregroundColor(Color("TextColor")).opacity(0.3)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                //Bottom rectangle
                HStack {
                    Spacer()
                    VStack {
                        Text("""
                            Your latest
                            rating:
                            """)
                            .applyAntiTopTitleStyle()
                        Text(String(format: "%.1f", entryStore.todaysEntry()?.rating ?? 0))
                            .font(.system(size: 40, weight: .semibold, design: .default))
                    }
                    Spacer()
                    
                    VStack {
                        Text("""
                            Your latest
                            mood:
                            """)
                            .applyAntiTopTitleStyle()
                        Text("\(entryStore.todaysEntry()?.mood.rawValue ?? "😐")")
                            .font(.system(size: 40, weight: .semibold, design: .default))
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 3)
                    .foregroundColor(Color("TextColor")).opacity(0.3)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                //Middle rectangle
                Reminder(
                    targetTime: $targetTime,
                    journalTime: $journalTime,
                    profileStore: profileStore,
                    isTargetsExpanded: false,
                    isJournalExpanded: false,
                    onTapSaveTargetTime: onTapSaveTargetTime,
                    onTapSaveJournalTime: onTapSaveJournalTime
                )
                    .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}
