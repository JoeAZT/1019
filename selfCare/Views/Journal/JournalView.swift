//
//  JournalView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI

struct JournalView: View {
    
    @ObservedObject var entryStore: EntryStore
    
    var body: some View {
        
        VStack {
            Text("Journal")
                .fontWeight(.semibold)
                .foregroundColor(Color("TextColor"))
                .font(.title)
                .padding()
            
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
        }
    }
}


