//
//  ProfileView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI

struct ProfileView: View {
    
    @State var nameText: String = ""
    @State var goalTime = Date()
    @State var journalTime = Date()
    var body: some View {
    
        VStack {
            Text("Profile")
                .fontWeight(.semibold)
                .foregroundColor(Color("TextColor"))
                .font(.title)
                .padding()

            Text("Your name:")
                .fontWeight(.bold)
                .frame(width: 370, height: 20, alignment: .leading)
                .foregroundColor(Color("TextColor"))
                .padding()

            ZStack(alignment: .topLeading) {
                TextViewWrapper(text: $nameText)
                    .frame(width: 340, height: 40, alignment: .center)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("TextColor"), lineWidth: 4))
                    .padding(.bottom, 10)
                if nameText.isEmpty {
                    Text("Name?")
                        .opacity(0.4)
                        .padding(.all, 25)
                        .padding(.trailing, 110)
                }
            }
            
            Text("When do you want to fill out your goals each day?")
                DatePicker("", selection: $goalTime, displayedComponents: .hourAndMinute)
                    .frame(minWidth: 300, idealWidth: 300, maxWidth: 300, minHeight: 20, idealHeight: 20, maxHeight: 0, alignment: .center)
                    .labelsHidden()
                    .padding(20)


            Text("When do you want to fill out your journal each day?")
                DatePicker("", selection: $journalTime, displayedComponents: .hourAndMinute)
                    .frame(minWidth: 300, idealWidth: 300, maxWidth:340, minHeight: 50, idealHeight: 100, maxHeight: 50, alignment: .center)
                    .labelsHidden()
                    .font(.system(size: 100, weight: .bold, design: .default))
        }
        .padding(.horizontal, 300)
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
