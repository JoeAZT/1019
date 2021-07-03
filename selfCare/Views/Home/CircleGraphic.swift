//
//  CircleGraphic.swift
//  selfCare
//
//  Created by Joseph Taylor on 26/05/2021.
//

import SwiftUI

struct CircleGraphic: View {
    let rating: Double
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("ModeColor"))
                .opacity(0.2)
            
            VStack {
                Text("Your average rating:")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                    .padding()
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 15)
                        .opacity(0.1)
                        .foregroundColor(.black)
                    
                    VStack {
                        Text(String(format: "%.1f", rating))
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
                    }
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(self.rating / 10))
                        .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                        .animation(Animation.easeInOut(duration: 2.0))
                        .rotationEffect(.degrees(-90))
                }
                .padding()
                .padding(.bottom, 5)
            }
        }
    }
}

struct CircleGraphic_Previews: PreviewProvider {
    static var previews: some View {
        CircleGraphic(rating: 0.5)
    }
}
