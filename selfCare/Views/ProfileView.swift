//
//  ProfileView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var nameText: String = ""
    @State var goalTime = Date()
    @State var journalTime = Date()
    @State var image: UIImage?
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @ObservedObject var entryStore: EntryStore
    @ObservedObject var goalStore: GoalStore
    @ObservedObject var profileStore: ProfileStore
    @State var toggleApperance = false
    @State var nameExpand = false
    
    @State var hasChanges = false
    
    var body: some View {
        
        let circleSize = CGFloat(150)
    
        VStack {
            HStack {
                Button(action: {
                    guard hasChanges else {
                        self.presentationMode.wrappedValue.dismiss()
                        return
                    }
                    if let data = image?.pngData() {
                        let profile = Profile(profilePicture: data,
                                              name: nameText,
                                              targetReminder: Date(),
                                              journalReminder: Date())
                        profileStore.updateProfile(profile)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .padding()
                        .font(.system(size: 30))
                        .foregroundColor(Color("TextColor"))
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                })
                Spacer()
                
                Text("Profile")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TextColor"))
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    print("toggle dark/light mode")
                    
                }, label: {
                    Image(systemName: "moon.circle.fill")
                        .padding()
                        .font(.system(size: 30))
                        .foregroundColor(Color("TextColor"))
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                })
            }
            
            Group {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(minWidth: circleSize, idealWidth: circleSize, maxWidth: circleSize, minHeight: circleSize, idealHeight: circleSize, maxHeight: circleSize, alignment: .center)
                } else if let imageData = profileStore.profile?.profilePicture, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(minWidth: circleSize, idealWidth: circleSize, maxWidth: circleSize, minHeight: circleSize, idealHeight: circleSize, maxHeight: circleSize, alignment: .center)
                } else {
                    ZStack {
                        Circle()
                            .frame(minWidth: circleSize, idealWidth: circleSize, maxWidth: circleSize, minHeight: circleSize, idealHeight: circleSize, maxHeight: circleSize, alignment: .center)
                            .foregroundColor(Color("TextColor").opacity(0.4))
                            .applyShadow()
                            .padding()
                        
                        Text("Tap here to add profile picture")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("ModeColor"))
                            .font(.system(size: 13, weight: .regular, design: .default))
                            .frame(width: 100, height: 50, alignment: .center)
                    }
                }
            }
            .onTapGesture {
                self.showingImagePicker = true
            }
            
            VStack {
                if nameExpand == false {
                    Text(nameText == "" ? "Add Your Name" : nameText)
                        .font(.system(size: 40, weight: .semibold, design: .default))
                        .onTapGesture {
                            nameExpand = true
                        }
                } else {
                    HStack {
                    TextViewWrapper(text: $nameText)
                        .frame(height: 40, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("ModeColor"), lineWidth: 4)
                        )
                        Button(action: {
                            nameExpand = false
//                            let profile = Profile(profilePicture: data,
//                                                  name: nameText,
//                                                  targetReminder: Date(),
//                                                  journalReminder: Date())
//                            profileStore.updateProfile(profile)
                        }, label: {
                            Text("Done")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .pink]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(15)
                        })
                    }
                    .padding()
                    .padding(.horizontal, 10)
                }
            }
            
            //Top rectangle
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color("ModeColor"))
                    .applyShadow()
                
                HStack {
                    VStack {
                        Text("Journal Entries:")
                            .applyTopTitleStyle()
                        Text("\(entryStore.entries.count)")
                            .font(.system(size: 50, weight: .semibold, design: .default))
                            .padding(.top, 8)
                    }
                    .padding()
                    
                    VStack {
                        Text("Consecutive active days:")
                            .applyTopTitleStyle()
                        Text("12")
                            .font(.system(size: 50, weight: .semibold, design: .default))
                            .padding(.top, 8)
                    }
                    .padding()
                    
                    VStack {
                        Text("Goal Completed:")
                            .applyTopTitleStyle()
                        Text("\(goalStore.goals.count)")
                            .font(.system(size: 50, weight: .semibold, design: .default))
                            .padding(.top, 8)
                    }
                }
                .padding(.horizontal)
            }
            
            //Middle rectangle
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                    VStack {
                    Text("Targets Reminder:")
                        .applyMiddleTitleStyle()
                        DatePicker("", selection: $goalTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                }
                .padding(5)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                    VStack {
                    Text("Jounral Reminder:")
                        .applyMiddleTitleStyle()
                        DatePicker("", selection: $journalTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    }
                }
                .padding(5)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color("ModeColor"))
                    .applyShadow()
                
                //Bottom rectangle
                HStack {
                    VStack {
                        Text("Your latest rating:")
                            .applyBottomTitleStyle()
                        Text(String(format: "%.1f", entryStore.todaysEntry()?.rating ?? 0))
                            .font(.system(size: 60, weight: .semibold, design: .default))
                    }
                    .padding(.trailing, 50)
                    
                    VStack {
                        Text("Your latest mood:")
                            .applyBottomTitleStyle()
                        Text("\(entryStore.todaysEntry()?.mood.rawValue ?? "None")")
                            .font(.system(size: 60, weight: .semibold, design: .default))
                    }
                }
                .padding()
            }
        }
        .padding(.horizontal, 10)
        .navigationBarTitle("Pick a photo")
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = inputImage
        hasChanges = true
    }
}
        
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//Modifiers

struct shadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 2)
    }
}

struct TopTitlesModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 18, weight: .regular, design: .default))
            .foregroundColor(Color("TextColor")).opacity(0.4)
            .multilineTextAlignment(.center)
    }
}

struct MiddleTitlesModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .multilineTextAlignment(.center)
            .font(.system(size: 20, weight: .semibold, design: .default))
    }
}

struct BottomTitlesModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .multilineTextAlignment(.center)
            .font(.system(size: 15, weight: .regular, design: .default))
            .foregroundColor(Color("TextColor")).opacity(0.4)
            .padding(5)
    }
}

extension View {
    func applyShadow() -> some View {
        return self.modifier(shadowModifier())
    }
}

extension View {
    func applyTopTitleStyle() -> some View {
        return self.modifier(TopTitlesModifier())
    }
}

extension View {
    func applyMiddleTitleStyle() -> some View {
        return self.modifier(MiddleTitlesModifier())
    }
}

extension View {
    func applyBottomTitleStyle() -> some View {
        return self.modifier(BottomTitlesModifier())
    }
}
