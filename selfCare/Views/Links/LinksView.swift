//
//  LifestyleView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI

struct LinksView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        
        Text("Your Links this week:")
            .fontWeight(.semibold)
            .foregroundColor(Color("TextColor"))
            .font(.title)
            .padding()
        
        VStack {
            List {
                ForEach(1..<10) {_ in
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .padding()
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)
                        Text("Lots of text about related article")
                    }
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    
        
}


struct LinksView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
