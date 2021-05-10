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
        
        List {
            ForEach(entryStore.entries) { entry in
                Text(entry.happyText)
                    .fontWeight(.bold)
                    .foregroundColor(Color("TextColor"))
                    .frame(width: 300, height: 100, alignment: .center)
                    .background(Color.blue)
            }
        }
    }
}


