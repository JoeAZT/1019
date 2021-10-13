//
//  LifestyleView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI

struct LinksView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        //        Text("Your Links this week:")
        //            .fontWeight(.semibold)
        //            .foregroundColor(Color("TextColor"))
        //            .font(.title)
        //            .padding()
        //
        //        VStack {
        //            List {
        //                ForEach(1..<10) {_ in
        //                    HStack {
        //                        Image(systemName: "person.circle.fill")
        //                            .padding()
        //                            .font(.system(size: 50))
        //                            .foregroundColor(.white)
        //                            .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)
        //                        Text("Lots of text about related article")
        //                    }
        //                }
        //            }
        //        }
        //        .preferredColorScheme(isDarkMode ? .dark : .light)
        
        VStack {
            HStack {
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left.circle.fill")
                        .padding()
                        .font(.system(size: 30))
                        .foregroundColor(Color("TextColor"))
                        .applyShadow()
                }
                
                Spacer()
                
                Text("Links")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TextColor"))
                    .font(.title)
                    .padding()
                
                Spacer()
                
                Button(action: {
                }) {
                    Image(systemName: "chevron.left.circle.fill")
                        .padding()
                        .font(.system(size: 30))
                        .foregroundColor(Color("TextColor")).opacity(0)
                }
            }
            
            Spacer()
            
            VStack {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 200, weight: .regular, design: .default))
                    .padding(.bottom, 60)
                
                Text("This area of the app is currently under developement.")
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 60)
            .opacity(0.4)
            
            Spacer()
        }
    }
}


struct LinksView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
