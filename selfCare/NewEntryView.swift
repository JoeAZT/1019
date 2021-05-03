//
//  NewEnrtyView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI

struct NewEntryView: View {
    
    @State var ratingSlider: Double = 0.0
    @State var reflectionText: String = "It's ok not to write anything today if you don't want to"
    @State var happyText: String = "It's ok not to write anything today if you don't want to"
    
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
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                }
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
                Text(String(format: "Why was you day %.1f?", ratingSlider))
                    .fontWeight(.bold)
                    .frame(width: 370, height: 20, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                
                TextEditor(text: $reflectionText)
                    .frame(width: 340, height: 300, alignment: .leading)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 4))
                    
                    .padding(.vertical)
                
                Text("What made you happy today?")
                    .fontWeight(.bold)
                    .frame(width: 370, height: 20, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                
                TextEditor(text: $happyText)
                    .frame(width: 340, height: 300, alignment: .center)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 4))
                    
                    .padding(.vertical)
                
            }
        }
    }
}


struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

