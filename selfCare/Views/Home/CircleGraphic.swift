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
            //Circle Track
            Circle()
                .stroke(lineWidth: 40)
                .opacity(0.1)
                .foregroundColor(.black)
                .frame(width: 300, height: 300, alignment: .center)
            
            VStack {
                Text("Your average rating:")
                    .font(.system(size: 15, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                
                Text(String(format: "%.1f", rating))
                    .font(.system(size: 130))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
            }
            
            Circle()
                .trim(from: 0.0, to: CGFloat(self.rating / 10))
                .stroke(style: StrokeStyle(lineWidth: 40.0, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300, alignment: .center)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                .animation(Animation.easeInOut(duration: 2.0))
                .rotationEffect(.degrees(-90))
        }
        .padding(.horizontal, 65)
        .padding(.vertical, 150)
    }
}

struct CircleGraphic_Previews: PreviewProvider {
    static var previews: some View {
        CircleGraphic(rating: 0.5)
    }
}
