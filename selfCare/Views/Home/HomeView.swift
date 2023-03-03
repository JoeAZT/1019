//
//  ContentView.swift
//  selfCare
//
//  Created by Joseph Taylor on 01/05/2021.
//

import IrregularGradient
import SwiftUI

struct HomeView: View {
    
    @State private var showJournalView = false
    @State private var showNewEntryView = false
    @State private var showGoalsView = false
    @State private var showProfileView = false
    @State private var showLinksView = false
    @StateObject var entryStore = EntryStore()
    @StateObject var dailyGoalStore = DailyGoalStore()
    @StateObject var weeklyGoalStore = WeeklyGoalStore()
    @StateObject var longTermGoalStore = LongTermGoalStore()
    @StateObject var profileStore = ProfileStore()
    @State var selectedPage = 0
    @AppStorage("isDarkMode") private var isDarkMode = false
        
    var body: some View {
        
        VStack {
            HStack {
                //Profile
                Button(action: {
                    showProfileView.toggle()
                }, label: {
                    Image(systemName: "person.circle.fill")
                        .padding()
                        .font(.system(size: 50))
                        .foregroundColor(Color("ModeColor"))
                        .shadow(color: Color("TextColor").opacity(0.25), radius: 3, x: 1, y: 1)
                })
                .sheet(isPresented: $showProfileView, content: {

                    ProfileView(entryStore: entryStore, longTermGoalStore: longTermGoalStore, dailyGoalStore: dailyGoalStore, weeklyGoalStore: weeklyGoalStore, profileStore: profileStore)
                        .presentationDetents([.fraction(0.6)])
                })
                
                
                Spacer()
                //Logo
                Image("selfCare logo")
                    .resizable()
                        .scaledToFit()
                        .frame(width: 60.0, height: 60.0)
                    .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)
                    .onAppear(perform: {
                    })

                Spacer()
                
                //Links
                Button(action: {
                    showLinksView.toggle()
                    
                }, label: {
                    Image(systemName: "link.circle.fill")
                        .padding()
                        .font(.system(size: 50))
//                        .foregroundColor(.white)
                        .foregroundColor(Color("ModeColor"))
//                        .shadow(color: Color("TextColor").opacity(0.5), radius: 3)
                        .shadow(color: Color("TextColor").opacity(0.25), radius: 3, x: 1, y: 1)
                })
                .sheet(isPresented: $showLinksView, content: {
                    LinksView()
                })
            }
            
            VStack(alignment: .leading) {
                Text(profileStore.profile?.name == nil ? "Welcome to selfCare" : "Welcome back, \(profileStore.profile!.name)")
                    .font(.system(size: 25, weight: .black, design: .default))
//                    .foregroundColor(.white)
                    .foregroundColor(Color("ModeColor"))
                HStack {
                    CircleGraphic(rating: entryStore.average())
                    
                    FeelingsGraphs(entryStore: entryStore)
                }
                .layoutPriority(1)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("ModeColor"))
//                        .opacity(0.2)
                    
                    VStack(alignment: .leading) {
                        Text("Your mood this week:")
                            .font(.system(size: 20, weight: .bold, design: .default))
//                            .foregroundColor(.white)
                            .foregroundColor(Color("TextColor"))
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 14) {
                                ForEach(entryStore.sevenEntries.reversed()) { entry in
                                    Text(entry.mood.rawValue)
                                        .font(.system(size: 30, weight: .regular, design: .default))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }
                .frame(height: 100)
                VStack {
                TargetTabs(dailyGoalStore: dailyGoalStore, weeklyGoalStore: weeklyGoalStore)
                }.layoutPriority(1)
            }
            .padding()
            
            HStack {
                //Journal Button
                Button(action: {
                    showJournalView.toggle()
                }
                
                , label: {
                    Image(systemName: "book.circle.fill")
                        .padding(.horizontal)
                        .font(.system(size: 70))
//                        .foregroundColor(.white)
                        .foregroundColor(Color("ModeColor"))
                        .shadow(color: Color("TextColor").opacity(0.25), radius: 3, x: 1, y: 1)
//                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)
                })
                .sheet(isPresented: $showJournalView, content: {
                    JournalView(entryStore: entryStore)
                })
                Spacer()
                
                //Add new entry button
                Button(action: {
                    showNewEntryView.toggle()
                    
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .padding(.horizontal)
                        .font(.system(size: 70))
//                        .foregroundColor(.white)
//                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)
                        .foregroundColor(Color("ModeColor"))
                        .shadow(color: Color("TextColor").opacity(0.25), radius: 3, x: 1, y: 1)
                })
                .sheet(isPresented: $showNewEntryView) {
                    NewEntryView(showNewEntryView: $showNewEntryView, entryStore: entryStore)
                }
                Spacer()
                
                //Goals Button
                Button(action: {
                    showGoalsView.toggle()
                }, label: {
                    Image(systemName: "target")
                        .padding(.horizontal)
                        .font(.system(size: 70))
//                        .foregroundColor(.white)
                        .foregroundColor(Color("ModeColor"))
//                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)
                        .shadow(color: Color("TextColor").opacity(0.25), radius: 3, x: 1, y: 1)
                })
                .sheet(isPresented: $showGoalsView) {
                    TargetsView(longTermGoalStore: longTermGoalStore, weeklyGoalStore: weeklyGoalStore, dailyGoalStore: dailyGoalStore)
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .embedInBackground()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct GradientBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
//                .irregularGradient(colors: [.purple, .pink, .blue, .purple ], backgroundColor: .black.opacity(0.4))
                .irregularGradient(colors: [.purple, .pink, .blue, .purple ], backgroundColor: .black.opacity(0.4))
                .ignoresSafeArea(.all, edges: .all)
            content
        }
    }
}

extension View {
    func rotationEffect(x: Int, y: Int, z: Int) {
        
    }
}

extension View {
    func embedInBackground() -> some View {
        self.modifier(GradientBackgroundModifier())
    }
}
