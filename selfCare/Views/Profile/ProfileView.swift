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
    
    var hasChanges: Bool {
        return inputImage != nil || targetTime != profileStore.profile?.targetTime || journalTime != profileStore.profile?.journalTime || nameText != profileStore.profile?.name
    }
    
    @State var lightMode = true
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State var targetTime: Date
    @State var journalTime: Date
    
    init(entryStore: EntryStore, longTermGoalStore: LongTermGoalStore, dailyGoalStore: DailyGoalStore, weeklyGoalStore: WeeklyGoalStore, profileStore: ProfileStore
    ) {
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
    
    //MARK: - Save Profile function
    func saveProfile(_ shouldDismiss: Bool = false) {
        guard hasChanges else {
            if shouldDismiss {
                self.presentationMode.wrappedValue.dismiss()
            }
            return
        }
        
        let profile = Profile(profilePicture:image?.pngData(), name: nameText, targetTime: targetTime, journalTime: journalTime)
        profileStore.updateProfile(profile)
        if shouldDismiss {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    //MARK: - View
    var body: some View {
        VStack {
            TopItemsProfile
            ScrollView {
                StatsView(
                    targetTime: $targetTime,
                    journalTime: $journalTime,
                    profileStore: profileStore,
                    entryStore: entryStore,
                    longTermGoalStore: longTermGoalStore,
                    dailyGoalStore: dailyGoalStore,
                    weeklyGoalStore: weeklyGoalStore,
                    onTapSaveTargetTime: {
                        saveProfile()
                    },
                    onTapSaveJournalTime: {
                        saveProfile()
                    }
                )
            }
            .padding(.horizontal)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = inputImage
    }
    
    //MARK: - Top Items: Code associated with the top of the view are held here.
    var TopItemsProfile: some View {
        VStack {
            HStack {
                Button(action: {
                    saveProfile(true)
                }, label: {
                    Image(systemName: "multiply")
                        .padding()
                        .font(.system(size: 30))
                        .foregroundColor(.pink)
                        .applyShadow()
                })
                Spacer()
                
                Text("Your Profile")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TextColor"))
                    .font(.title)
                //here for image
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
//            Group {
//                if let image = image {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFit()
//                        .clipShape(Circle())
//                        .frame(minWidth: circleSize, idealWidth: circleSize, maxWidth: circleSize, minHeight: circleSize, idealHeight: circleSize, maxHeight: circleSize, alignment: .center)
//                } else {
//                    ZStack {
//                        Circle()
//                            .frame(minWidth: circleSize, idealWidth: circleSize, maxWidth: circleSize, minHeight: circleSize, idealHeight: circleSize, maxHeight: circleSize, alignment: .center)
//                            .foregroundColor(Color("TextColor").opacity(0.4))
//                            .applyShadow()
//
//                        Text("Tap here to add profile picture")
//                            .multilineTextAlignment(.center)
//                            .foregroundColor(Color("TextColor"))
//                            .font(.system(size: 13, weight: .regular, design: .default))
//                            .frame(width: 100, height: 50, alignment: .center)
//                    }
//                }
//            }
//            .onTapGesture {
//                print("Tapped")
//                self.showingImagePicker = true
//            }
        }
    }
}

struct singleStatsViews: View {
    var string1: String
    var string2: String
    
    var body: some View {
        HStack {
            Text(string1)
                .bold()
            Spacer()
            Text(string2)
        }
    }
}
    
    //MARK: - Profile picture: Code associated with the profile picture is held here.
    let circleSize = CGFloat(60)

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//MARK: - Modifiers

struct shadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 2)
    }
}

struct TopTitlesModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding(.top, 10)
            .font(.system(size: 24, weight: .semibold, design: .default))
    }
}

struct MiddleTitlesModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .multilineTextAlignment(.center)
    }
}

struct BottomTitlesModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .multilineTextAlignment(.center)
            .foregroundColor(Color("ModeColor"))
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


//MARK: - Profile image/Image Picker

//            VStack {
//                if nameExpand == false {
//                    Text(nameText == "" ? "Add Your Name" : nameText)
//                        .font(.system(size: 40, weight: .semibold, design: .default))
//                        .foregroundColor(Color("TextColor"))
//                        .onTapGesture {
//                            nameExpand = true
//                        }
//                } else {
//                    HStack {
//                        TextViewWrapper(text: $nameText)
//                            .frame(height: 45, alignment: .center)
//                            .cornerRadius(10)
//
//                        Button(action: {
//                            nameExpand = false
//                            saveProfile()
//
//                        }, label: {
//                            Text("Done")
//                                .font(.system(size: 12, weight: .bold))
//                                .foregroundColor(.white)
//                                .padding()
//                                .background(Color.green)
//                                .cornerRadius(10)
//                        })
//                    }
//                    .padding(.horizontal, 10)
//                }

//    var PictureItemProfile: some View {
//        HStack {
////            if nameExpand == false {
////                Text(nameText == "" ? "Add Your Name" : nameText)
////                    .font(.system(size: 40, weight: .semibold, design: .default))
////                    .foregroundColor(Color("TextColor"))
////                    .onTapGesture {
////                        nameExpand = true
////                    }
////            } else {
////                HStack {
////                    TextViewWrapper(text: $nameText)
////                        .frame(height: 45, alignment: .center)
////                        .cornerRadius(10)
////
////                    Button(action: {
////                        nameExpand = false
////                        saveProfile()
////
////                    }, label: {
////                        Text("Done")
////                            .font(.system(size: 12, weight: .bold))
////                            .foregroundColor(.white)
////                            .padding()
////                            .background(Color.green)
////                            .cornerRadius(10)
////                    })
////                }
////                .padding(.horizontal, 10)
////            }
//            Group {
//                if let image = image {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFit()
//                        .clipShape(Circle())
//                        .frame(minWidth: circleSize, idealWidth: circleSize, maxWidth: circleSize, minHeight: circleSize, idealHeight: circleSize, maxHeight: circleSize, alignment: .center)
//                } else {
//                    ZStack {
//                        Circle()
//                            .frame(minWidth: circleSize, idealWidth: circleSize, maxWidth: circleSize, minHeight: circleSize, idealHeight: circleSize, maxHeight: circleSize, alignment: .center)
//                            .foregroundColor(Color("TextColor").opacity(0.4))
//                            .applyShadow()
//
//                        Text("Tap here to add profile picture")
//                            .multilineTextAlignment(.center)
//                            .foregroundColor(Color("TextColor"))
//                            .font(.system(size: 13, weight: .regular, design: .default))
//                            .frame(width: 100, height: 50, alignment: .center)
//                    }
//                }
//            }
//            .onTapGesture {
//                self.showingImagePicker = true
//            }
//        }
//    }

//MARK: - Main Card with stats
//
//            StatsView(
//                targetTime: $targetTime,
//                journalTime: $journalTime,
//                profileStore: profileStore,
//                entryStore: entryStore,
//                longTermGoalStore: longTermGoalStore,
//                dailyGoalStore: dailyGoalStore,
//                weeklyGoalStore: weeklyGoalStore,
//                onTapSaveTargetTime: {
//                    saveProfile()
//                },
//                onTapSaveJournalTime: {
//                    saveProfile()
//                }
//            )
//            .ignoresSafeArea()
//        }
//        .preferredColorScheme(isDarkMode ? .dark : .light)
//        .navigationBarTitle("Pick a photo")
//        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
//            ImagePicker(image: self.$inputImage)
//        }
