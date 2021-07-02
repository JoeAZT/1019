//
//  JournalView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI

struct JournalView: View {
    
    @ObservedObject var entryStore: EntryStore
    @State private var showNewEntryView = false
    @State var expandedEntry: String?
    
    var body: some View {
        
        VStack {
            Text("Journal")
                .fontWeight(.semibold)
                .foregroundColor(Color("TextColor"))
                .font(.title)
                .padding()
            
                List {
                    ForEach(entryStore.entries.map(\.value)) { entry in
                        
                        VStack(alignment: .leading) {
                        Text(entry.date, style: .date)
                            .fontWeight(.bold)
                            
                            HStack {
                                VStack {
                                    Text("Mood")
                                        .font(.system(size: 30, weight: .semibold, design: .default))
                                    Text(entry.mood.rawValue)
                                        .font(.system(size: 50, weight: .bold, design: .default))
                                }
                                VStack {
                                    Text("Rating")
                                        .font(.system(size: 30, weight: .semibold, design: .default))
                                    Text(String(format: "%.1f", entry.rating))
                                        .font(.system(size: 50, weight: .bold, design: .default))
                                }
                            }
                            ScrollView(.horizontal) {
                                HStack(spacing: 40) {
                                    Text("🏋️")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .opacity(entry.exercise == true ? 1 : 0.2)
                                    Text("🛌")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .opacity(entry.water == true ? 1 : 0.2)
                                    Text("🚰")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .opacity(entry.water == true ? 1 : 0.2)
                                    Text("🍎")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .opacity(entry.fruit == true ? 1 : 0.2)
                                    Text("📚")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .opacity(entry.reading == true ? 1 : 0.2)
                                    Text("📈")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .opacity(entry.productivity == true ? 1 : 0.2)
                                    Text("🧘")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .opacity(entry.meditation == true ? 1 : 0.2)
                                    Text("☀️")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .opacity(entry.outside == true ? 1 : 0.2)
                                }
                            }
                            VStack {
                                if self.expandedEntry != entry.id {
                                    HStack{
                                        Spacer()
                                    Image(systemName: "chevron.compact.down")
                                        Spacer()
                                    }
                                } else {
                                    HStack{
                                        Spacer()
                                    Image(systemName: "chevron.compact.up")
                                        Spacer()
                                    }
                                    Text("Rating")
                                        .fontWeight(.bold)
                                    Text(entry.reflectionText)
                                    Text("Happy")
                                        .fontWeight(.bold)
                                    Text(entry.happyText)
                                    Text("Achieve")
                                        .fontWeight(.bold)
                                    Text(entry.achievementText)
                                }
                            }
                            .onTapGesture {
                                if self.expandedEntry == entry.id {
                                    self.expandedEntry = nil
                                } else {
                                    self.expandedEntry = entry.id
                                }
                            }
                        }
                    }
                        
                        
                if entryStore.entries.isEmpty {
                    VStack {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 200, weight: .regular, design: .default))
                            .padding(30)
                        
                        Text("When you create journal entries they will appear on this screen. It's ok if you dont want to write anything down some days, you just have to give me a rating.")
                            .font(.system(size: 20, weight: .regular, design: .default))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 60)
                    }
                    .opacity(0.4)
                    .padding(.bottom, 50)
                }
            }
            
            Button(action: {
                showNewEntryView.toggle()
                
            }, label: {
                Text("Create Entry")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .pink]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(15)
            })
        }
        
        .sheet(isPresented: $showNewEntryView) {
            NewEntryView(showNewEntryView: $showNewEntryView, entryStore: entryStore)
        }
    }
}



