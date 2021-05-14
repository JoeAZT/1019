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
            
            ZStack {
                List {
                    ForEach(entryStore.entries) { entry in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(Date().addingTimeInterval(600), style: .date)
                                    .fontWeight(.semibold)
                                Text(entry.reflectionText)
                            }
                            .frame(width: 220, height: 80, alignment: .leading)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color("TextColor"), lineWidth: 4))
                            .padding(5)
                            
                            VStack(alignment: .center) {
                                Text("Rating")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 15))
                                Text(String(format: "%.1f", entry.rating))
                                    .font(.system(size: 40))
                            }
                            .frame(width: 80, height: 80)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color("TextColor"), lineWidth: 4))
                            .padding(5)
                        }
                    }
                }
                
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
        
        .sheet(isPresented: $showNewEntryView) {
            NewEntryView(showNewEntryView: $showNewEntryView, entryStore: entryStore)
        }
        
    }
}



