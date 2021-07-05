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
    @StateObject var goalStore = GoalStore()
    @StateObject var profileStore = ProfileStore()
    @State var selectedPage = 0
    
//    let greeting = profileStore.profile?.name = "" : "Welcome to selfCare" ? "Welcome back, \(profileStore.profile?.name)
//    if profileStore.profile?.name != "" {
//        let greeting = "Welcome back"
//    } else {
//        let greeting = "Welcome to selfCare"
//    }
    
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
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)
                })
                .sheet(isPresented: $showProfileView, content: {
                    ProfileView(entryStore: entryStore, goalStore: goalStore, profileStore: profileStore)
                })
                
                Spacer()
                //Logo
                Image("selfCare logo")
                    .resizable()
                        .scaledToFit()
                        .frame(width: 60.0, height: 60.0)
                    .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)

                Spacer()
                
                //Links
                Button(action: {
                    showLinksView.toggle()
                    
                }, label: {
                    Image(systemName: "link.circle.fill")
                        .padding()
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)
                })
                .sheet(isPresented: $showLinksView, content: {
                    LinksView()
                })
            }
            
            VStack(alignment: .leading) {
//                Text("Welcome back, \(profileStore.profile?.name)")
                Text("Welcome back")
                    .font(.system(size: 25, weight: .black, design: .default))
                    .foregroundColor(.white)
                HStack {
                    CircleGraphic(rating: entryStore.average())
                    
                    FeelingsGraphs(entryStore: entryStore)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("ModeColor"))
                        .opacity(0.2)
                    
                    VStack(alignment: .leading) {
                        Text("Your mood this week:")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.white)
            
                        ScrollView(.horizontal) {
                            HStack(spacing: 14) {
                                ForEach(entryStore.entries.map(\.value)) { entry in
                                    Text(entry.mood.rawValue)
                                        .font(.system(size: 30, weight: .regular, design: .default))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }
                .frame(height: 100)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("ModeColor"))
                        .opacity(0.2)
                    VStack(alignment: .leading) {
                        Text("Your daily targets:")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        
                        ScrollView {
                            ForEach(goalStore.goals.filter { $0.targetType == .daily }) { goal in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(Color("ModeColor"))
                                        .opacity(0.1)
                                    HStack {
                                        Text(goal.title)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(5)
                                        Spacer()
                                        Image(systemName: goal.completed ? "checkmark.square" : "square")
                                            .font(.system(size: 20, weight: .bold, design: .default))
                                            .foregroundColor(.white)
                                            .padding(5)
                                    }
                                    .onTapGesture {
                                        goalStore.toggleCompletedFor(goal)
                                    }
                                }
                            }
                            
                        }
                    }
                    .padding()
                    .padding(.horizontal, 10)
                }
                .frame(height: 200)
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
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)
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
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)
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
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)
                })
                .sheet(isPresented: $showGoalsView) {
                    TargetsView(goalStore: goalStore)
                }
            }
        }
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
                .irregularGradient(colors: [.purple, .pink, .blue ], backgroundColor: .black)
                .ignoresSafeArea(.all, edges: .all)
            content
        }
    }
}

extension View {
    func embedInBackground() -> some View {
        self.modifier(GradientBackgroundModifier())
    }
}
