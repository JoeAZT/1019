//
//  JournalView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI
import IrregularGradient

struct JournalView: View {
    
    @ObservedObject var entryStore: EntryStore
    @State private var showNewEntryView = false
    @State var expandedEntry: String?
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        
        VStack {
            Text("Journal")
                .fontWeight(.semibold)
                .foregroundColor(Color("TextColor"))
                .font(.title)
                .padding()
            
            List {
                ForEach(entryStore.sortedEntries) { entry in
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("ModeColor"))
                            .applyShadow()
                        
                        VStack(alignment: .leading) {
                            
                            HStack {
                                Text(entry.mood.rawValue)
                                    .font(.system(size: 60, weight: .bold, design: .default))
                                
                                VStack(alignment: .leading) {
                                    Text(entry.date, style: .date)
                                        .font(.system(size: 15, weight: .medium, design: .default))
                                    HStack {
                                        Text("Rating:")
                                            .font(.system(size: 17, weight: .bold, design: .default))
                                        Text(String(format: "%.1f", entry.rating))
                                            .font(.system(size: 17, weight: .bold, design: .default))
                                    }
                                }
                                .padding()
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.gray)
                                        .opacity(0.1)
                                        .frame(height: 60)
                                    VStack {
                                        HStack {
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
                                        }
                                        HStack {
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
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.top, 5)
                            
                            
                            VStack(alignment: .leading) {
                                if self.expandedEntry != entry.id {
                                    HStack{
                                        Spacer()
                                        Image(systemName: "chevron.compact.down")
                                            .font(.system(size: 20, weight: .bold, design: .default))
                                            .opacity(0.4)
                                            .padding(.bottom, 2)
                                        Spacer()
                                    }
                                } else {
                                    Text("How was your day?:")
                                        .fontWeight(.bold)
                                    Text(entry.reflectionText)
                                        .padding(.bottom)
                                    Text("What made you happy?:")
                                        .fontWeight(.bold)
                                    Text(entry.happyText)
                                        .padding(.bottom)
                                    Text("What did you achieve?:")
                                        .fontWeight(.bold)
                                    Text(entry.achievementText)
                                        .padding(.bottom)
                                    HStack{
                                        Spacer()
                                        Image(systemName: "chevron.compact.up")
                                            .font(.system(size: 20, weight: .bold, design: .default))
                                            .padding(.bottom, 5)
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .layoutPriority(1)
                        }
                    }
                    .onTapGesture {
                        if self.expandedEntry == entry.id {
                            self.expandedEntry = nil
                        } else {
                            self.expandedEntry = entry.id
                        }
                    }
                    .animation(.spring())
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
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}



