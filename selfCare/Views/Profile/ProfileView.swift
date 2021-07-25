//
//  ProfileView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI
import IrregularGradient
import UserNotifications

struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var nameText: String = ""
    @State var image: UIImage?
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @ObservedObject var entryStore: EntryStore
    @ObservedObject var longTermGoalStore: LongTermGoalStore
    @ObservedObject var dailyGoalStore: DailyGoalStore
    @ObservedObject var weeklyGoalStore: WeeklyGoalStore
    @ObservedObject var profileStore: ProfileStore
    @State var nameExpand = false
    @State var hasChanges = false
    @State var lightMode = true
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State var targetTime: Date
    @State var journalTime: Date
    
    init(entryStore: EntryStore, longTermGoalStore: LongTermGoalStore, dailyGoalStore: DailyGoalStore, weeklyGoalStore: WeeklyGoalStore, profileStore: ProfileStore) {
        self.entryStore = entryStore
        self.longTermGoalStore = longTermGoalStore
        self.dailyGoalStore = dailyGoalStore
        self.weeklyGoalStore = weeklyGoalStore
        self.profileStore = profileStore
        _nameText = State(initialValue: profileStore.profile?.name ?? "")
        
        if let imageData = profileStore.profile?.profilePicture, let image = UIImage(data: imageData) {
            _image = State(initialValue: image)
        }
        
        self._targetTime = State(initialValue: profileStore.profile?.targetTime ?? Date())
        self._journalTime = State(initialValue: profileStore.profile?.journalTime ?? Date())
    }
    
    var body: some View {
        
        let circleSize = CGFloat(150)
        
        VStack {
            HStack {
                Button(action: {
                    if let data = image?.pngData() {
                        let profile = Profile(profilePicture: data, name: nameText, targetTime: targetTime, journalTime: journalTime)
                        profileStore.updateProfile(profile)
                        self.presentationMode.wrappedValue.dismiss()
                    }
//                    guard hasChanges else {
//                        self.presentationMode.wrappedValue.dismiss()
//                        return
//                    }
                    
                }, label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .padding()
                        .font(.system(size: 30))
                        .foregroundColor(Color("TextColor"))
                        .applyShadow()
                })
                Spacer()
                
                Text("Profile")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TextColor"))
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    
                    if isDarkMode == false {
                        isDarkMode = true
                    } else {
                        isDarkMode = false
                    }
                    
                }, label: {
                    Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                        .font(.system(size: 30))
                        .foregroundColor(Color("TextColor"))
                        .padding()
                })
                .applyShadow()
            }
            ScrollView {
                Group {
                    if let image = image {
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
                                        .stroke(Color("TextColor"), lineWidth: 4).opacity(0.4)
                                )
                            Button(action: {
                                nameExpand = false
                                if let data = image?.pngData() {
                                    let profile = Profile(profilePicture: data, name: nameText, targetTime: targetTime, journalTime: journalTime)
                                    profileStore.updateProfile(profile)
                                }
                                
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
                        }
                        .padding(10)
                        
                        VStack {
                            Text("Consecutive active days:")
                                .applyTopTitleStyle()
                            Text("0")
                                .font(.system(size: 50, weight: .semibold, design: .default))
                        }
                        .padding(10)
                        
                        VStack {
                            Text("Goals Completed:")
                                .applyTopTitleStyle()
                            let totalTargetCount = longTermGoalStore.goals.count + dailyGoalStore.goals.count + weeklyGoalStore.goals.count
                            Text("\(totalTargetCount)")
                                .font(.system(size: 50, weight: .semibold, design: .default))
                        }
                        .padding(10)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                
                //Middle rectangle
//                Reminder(targetTime: profileStore.profile?.targetTime ?? Date().adding(minutes: 59), journalTime: profileStore.profile?.journalTime ?? Date().adding(minutes: 59), profileStore: profileStore, isExpanded: false)
                Reminder(targetTime: $targetTime, journalTime: $journalTime, profileStore: profileStore, isExpanded: false)
                
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
                        
                        VStack {
                            Text("Your latest mood:")
                                .applyBottomTitleStyle()
                            Text("\(entryStore.todaysEntry()?.mood.rawValue ?? "?")")
                                .font(.system(size: 60, weight: .semibold, design: .default))
                        }
                    }
                    .padding()
                }
            }.preferredColorScheme(isDarkMode ? .dark : .light)
            .padding(.horizontal, 10)
            .navigationBarTitle("Pick a photo")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
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
            .font(.system(size: 16, weight: .regular, design: .default))
            .foregroundColor(Color("TextColor")).opacity(0.4)
            .multilineTextAlignment(.center)
            .frame(width: 100)
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
            .font(.system(size: 16, weight: .regular, design: .default))
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

extension Date {
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}
