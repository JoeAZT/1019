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
    
    var body: some View {
        
        VStack {
            Text("Journal")
                .fontWeight(.semibold)
                .foregroundColor(Color("TextColor"))
                .font(.title)
                .padding()
            
            VStack {
                ZStack {
                    List {
                        ForEach(entryStore.entries.map(\.value)) { entry in
                                HStack {
                                    //Date and description
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 300, height: 200, alignment: .center)
                                            .foregroundColor(Color("ModeColor"))
                                            .applyShadow()
                                        
                                        VStack {
                                            HStack{
                                                Text(entry.date, style: .date)
                                                    .fontWeight(.semibold)
                                                Spacer()
                                            }
                                            Text(entry.reflectionText)
                                                .multilineTextAlignment(.leading)
                                                .padding(.vertical, 5)
                                                .padding(.trailing, 10)
                                            Text(entry.happyText)
                                                .multilineTextAlignment(.leading)
                                        }
                                        .frame(width: 280, height: 200, alignment: .leading)
                                    }
                                    Spacer()
                                    
                                    VStack {
                                        //Rating
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: 80, height: 95, alignment: .center)
                                                .foregroundColor(Color("ModeColor"))
                                                .applyShadow()
                                            VStack(alignment: .center) {
                                                Text("Rating")
                                                    .fontWeight(.semibold)
                                                    .font(.system(size: 14))
                                                    .padding(1)
                                                Text(String(format: "%.1f", entry.rating))
                                                    .font(.system(size: 24, weight: .bold, design: .default))
                                            }
                                            .frame(width: 50, height: 50)
                                        }
                                        
                                        //Mood
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: 80, height: 95, alignment: .center)
                                                .foregroundColor(Color("ModeColor"))
                                                .applyShadow()
                                            VStack(alignment: .center) {
                                                Text("Mood")
                                                    .fontWeight(.semibold)
                                                    .font(.system(size: 15))
                                                Text(entry.mood.rawValue)
                                                    .font(.system(size: 40))
                                            }
                                            .frame(width: 50, height: 50)
                                        }
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
        }
        
        .sheet(isPresented: $showNewEntryView) {
            NewEntryView(showNewEntryView: $showNewEntryView, entryStore: entryStore)
        }
        
    }
}



