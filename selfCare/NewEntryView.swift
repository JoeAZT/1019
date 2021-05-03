//
//  NewEnrtyView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI

struct NewEntryView: View {
    
    @State var ratingSlider: Double = 0.0
    @State var reflectionText: String = ""
    @State var happyText: String = ""
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                //Screen Title
                Text("New Entry")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                
                //First line
                HStack {
                    Text("How was your day?")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text(String(format: "%.1f", ratingSlider))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                //Slider
                
                HStack {
                    
                    Text("0")
                    ZStack {
                        
                        
                        LinearGradient(
                            gradient: Gradient(colors: [.pink, .blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(Slider(value: $ratingSlider, in: 0.0...10.0))
                        
                        Slider(value: $ratingSlider, in: 0.0...10.0)
                            .opacity(0.05)
                    }
                    Text("10")
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                //Reflection
                Text(String(format: "Why was your day %.1f/10?", ratingSlider))
                    .fontWeight(.bold)
                    .frame(width: 370, height: 20, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                    .padding(.bottom, 15)
                
                ZStack(alignment: .top) {
                    
                    TextViewWrapper(text: $reflectionText)
                        .frame(width: 340, height: 300, alignment: .leading)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white, lineWidth: 4))
                    
                    if reflectionText.isEmpty {
                        Text("Today I felt...")
                            .opacity(0.3)
                            .padding(.all, 25)
                            .padding(.trailing, 230)
                    }
                }
                
                
                //.padding(.vertical)
                
                Text("What made you happy today?")
                    .fontWeight(.bold)
                    .frame(width: 370, height: 20, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                    .padding()
                
                
                ZStack(alignment: .top) {
                    TextViewWrapper(text: $happyText)
                        .frame(width: 340, height: 300, alignment: .center)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white, lineWidth: 4))
                    
                    //.padding(.vertical)
                    
                    if happyText.isEmpty {
                        Text("I was happy today because...")
                            .opacity(0.4)
                            .padding(.all, 25)
                            .padding(.trailing, 110)
                    }
                }
                
                Button(action: {
                    print("Complete Entry")
                    
                    
                }, label: {
                    Text("Complete Entry")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .pink]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(15)
                })
                .padding()
                
            }
        }
    }
}


struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

