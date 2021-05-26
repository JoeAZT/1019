//
//  ContentView.swift
//  selfCare
//
//  Created by Joseph Taylor on 01/05/2021.
//

import IrregularGradient
import SwiftUI

struct HomeView: View {
    
    @State private var rating: Double = 0.00001
    @State private var wave = false
    @State private var showJournalView = false
    @State private var showNewEntryView = false
    @State private var showGoalsView = false
    @State private var showProfileView = false
    @State private var showLinksView = false
    @StateObject var entryStore = EntryStore()
    @StateObject var goalStore = GoalStore()
    
    @State var selectedPage = 0
    
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
                    ProfileView()
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
            
            //Tab view sections
            TabView(selection: $selectedPage) {
                CircleGraphic(rating: rating)
                .tag(0)
                
                FeelingsGraphs()
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle())
            
            Spacer()
            
            HStack {
                
                //Journal Button
                Button(action: {
                    
                    self.rating = Double.random(in: 0.0...1.0)
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
                    
                    self.rating = Double.random(in: 0.0...1.0)
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
                    Image(systemName: "checkmark.circle.fill")
                        .padding(.horizontal)
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)
                })
                .sheet(isPresented: $showGoalsView) {
                    GoalsView(goalStore: goalStore)
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


