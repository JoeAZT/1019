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
            ScrollView {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            Text(
                                """
                                Consecutive
                                Entries:
                                """)
                                .font(.system(size: 16))
                                .multilineTextAlignment(.center)
                            Text(String(entryStore.conseqEntries()))
                                .font(.system(size: 40, weight: .semibold, design: .default))
                        }
                        .foregroundColor(Color("ModeColor"))
                        
                        Spacer()
                        VStack {
                            Text("""
                                Journal
                                Entries:
                                """)

                                .font(.system(size: 16))
                                .multilineTextAlignment(.center)
                            Text("\(entryStore.entries.count)")
                                .font(.system(size: 40, weight: .semibold, design: .default))
                        }
                        .foregroundColor(Color("ModeColor"))
                        
                        Spacer()
                        VStack {
                            Text("""
                                Goals
                                Completed:
                                """)
                                .font(.system(size: 16))
                                .multilineTextAlignment(.center)
                            let totalTargetCount = longTermGoalStore.goals.count + dailyGoalStore.goals.count + weeklyGoalStore.goals.count
                            Text("\(totalTargetCount)")
                                .font(.system(size: 40, weight: .semibold, design: .default))
                        }
                        .foregroundColor(Color("ModeColor"))
                        Spacer()
                    }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 3)
                        .foregroundColor(Color("ModeColor")).opacity(0.3)
                        .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    //Middle section
                    HStack {
                        Spacer()
                        VStack {
                            Text("""
                            Your latest
                            rating:
                            """)
                                .applyTopTitleStyle()
                            Text(String(format: "%.1f", entryStore.todaysEntry()?.rating ?? 0))
                                .font(.system(size: 35, weight: .semibold, design: .default))
                        }
                        .foregroundColor(Color("ModeColor"))
                        
                        Spacer()
                        
                        VStack {
                            Text("""
                            Your latest
                            mood:
                            """)
                                .applyTopTitleStyle()
                            Text("\(entryStore.todaysEntry()?.mood.rawValue ?? "😐")")
                                .font(.system(size: 35, weight: .semibold, design: .default))
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 3)
                        .foregroundColor(Color("ModeColor")).opacity(0.3)
                        .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    //Bottom section
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
}
