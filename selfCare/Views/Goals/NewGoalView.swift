//
//  NewGoalView.swift
//  selfCare
//
//  Created by Joseph Taylor on 11/05/2021.
//

import SwiftUI

struct NewGoalView: View {
    
    @State var goalText: String = ""
    @Binding var showGoalView: Bool
    @ObservedObject var goalStore: GoalStore
    
    var body: some View {
        
        VStack {
            
            //Screen Title
            Text("New Goal")
                .fontWeight(.semibold)
                .foregroundColor(Color("TextColor"))
                .font(.title)
                .padding()
        
        ScrollView {
            
            Text("What's your goal?")
                .fontWeight(.bold)
                .frame(width: 370, height: 20, alignment: .leading)
                .foregroundColor(Color("TextColor"))
                .padding(.top, 50)
                .padding()
            
            
            ZStack(alignment: .top) {
                TextViewWrapper(text: $goalText)
                    .frame(width: 340, height: 300, alignment: .center)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("TextColor"), lineWidth: 4))
                
                //.padding(.vertical)
                
                if goalText.isEmpty {
                    Text("I was happy today because...")
                        .opacity(0.4)
                        .padding(.all, 25)
                        .padding(.trailing, 118)
                    }
                }
            
            
            
            }
        }
    }
}

