//
//  EditProfileView.swift
//  selfCare
//
//  Created by Joseph Taylor on 13/10/2021.
//

import SwiftUI
import IrregularGradient
import UserNotifications

struct EditProfileView: View {
    
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
    
    var body: some View {
        
        let circleSize = CGFloat(230)
        
        VStack {
            HStack {
                Button(action: {
                    saveProfile(true)
                    
                }, label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .padding()
                        .font(.system(size: 30))
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                })
                Spacer()
                
                Text("Profile")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("ModeColor"))
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
                        .foregroundColor(Color("ModeColor"))
                        .padding()
                })
                .applyShadow()
            }
            
            //Profile image / Image picker
            Group {
                if let image = image {
                    ZStack {
                        
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(minWidth: circleSize, idealWidth: circleSize, maxWidth: circleSize, minHeight: circleSize, idealHeight: circleSize, maxHeight: circleSize, alignment: .center)
                        
                        
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24 , weight: .semibold, design: .default))
                            .foregroundColor(Color("ModeColor"))
                            .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .pink]), startPoint: .topLeading, endPoint: .trailing))
                            .clipShape(Circle())
                            .padding(.leading, 110)
                            .padding(.bottom, 110)
                    }
                } else {
                    ZStack {
                        
                        Circle()
                            .frame(minWidth: circleSize, idealWidth: circleSize, maxWidth: circleSize, minHeight: circleSize, idealHeight: circleSize, maxHeight: circleSize, alignment: .center)
                            .foregroundColor(Color("ModeColor").opacity(0.4))
                            .applyShadow()
                        
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
                    HStack {
                        Text(nameText == "" ? "Add Your Name" : nameText)
                            .font(.system(size: 40, weight: .semibold, design: .default))
                            .foregroundColor(Color("ModeColor"))
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 24, weight: .semibold, design: .default))
                            .foregroundColor(Color("ModeColor"))
                            .padding(.top, 5)
                            .onTapGesture {
                                nameExpand = true
                            }
                    }
                    .padding(.leading, 30)
                } else {
                    HStack {
                        TextViewWrapper(text: $nameText)
                            .frame(height: 45, alignment: .center)
                            .cornerRadius(10)
                        
                        Button(action: {
                            nameExpand = false
                            saveProfile()
                            
                        }, label: {
                            Text("Done")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        })
                    }
                    .padding(.horizontal, 30)
                }
                
                //Main Card with stats
                StatsView(
                    targetTime: $targetTime,
                    journalTime: $journalTime,
                    profileStore: profileStore,
                    entryStore: entryStore,
                    longTermGoalStore: longTermGoalStore,
                    dailyGoalStore: dailyGoalStore,
                    weeklyGoalStore: weeklyGoalStore
                )
                .ignoresSafeArea()
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .navigationBarTitle("Pick a photo")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .pink]), startPoint: .topLeading, endPoint: .trailing).ignoresSafeArea())
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = inputImage
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
