//
//  TargetRow.swift
//  selfCare
//
//  Created by Joseph Taylor on 05/07/2021.
//

import SwiftUI

struct TargetRow: View {
    var goal: Goal
    var isExpanded: Bool
    var toggleCompleted: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 380, height: isExpanded ? 200 : 50, alignment: .center)
                .foregroundColor(Color("ModeColor"))
                .applyShadow()
            HStack {
                VStack(alignment: .leading) {
                    Text(goal.title)
                        .foregroundColor(goal.completed ? Color.gray : Color("TextColor"))
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                    if isExpanded {
                        Text(goal.goalText)
                    }
                }
                .padding(.horizontal, 10)
                Spacer()
                Image(systemName: goal.completed ? "checkmark.square" : "square")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .onTapGesture {
                        toggleCompleted()
                    }
            }
            .padding(8)
            .padding(.horizontal, 5)
        }
    }
}


