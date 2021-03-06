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
    
    @State var nameText: String
    @State var image: UIImage?
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
    
    @State private var showEditProfileView = false
    @State var lightMode = true
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State var targetTime: Date
    @State var journalTime: Date
    
    let onTapSaveTargetTime: () -> Void
    let onTapSaveJournalTime: () -> Void
    
    init(
        entryStore: EntryStore,
        longTermGoalStore: LongTermGoalStore,
        dailyGoalStore: DailyGoalStore,
        weeklyGoalStore: WeeklyGoalStore,
        profileStore: ProfileStore,
        onTapSaveTargetTime: @escaping () -> Void,
        onTapSaveJournalTime: @escaping () -> Void
    ) {
        self.entryStore = entryStore
        self.longTermGoalStore = longTermGoalStore
        self.dailyGoalStore = dailyGoalStore
        self.weeklyGoalStore = weeklyGoalStore
        self.profileStore = profileStore
        _nameText = State(initialValue: profileStore.profile?.name ?? "")
        
        self._targetTime = State(initialValue: profileStore.profile?.targetTime ?? Date())
        self._journalTime = State(initialValue: profileStore.profile?.journalTime ?? Date())
        
        if let imageData = profileStore.profile?.profilePicture, let image = UIImage(data: imageData) {
            _image = State(initialValue: image)
        }
        
        self.onTapSaveTargetTime = onTapSaveTargetTime
        self.onTapSaveJournalTime = onTapSaveJournalTime
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
                    showEditProfileView.toggle()
                }, label: {
                    Image(systemName: "pencil.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(Color("ModeColor"))
                        .padding()
                })
                .sheet(isPresented: $showEditProfileView, content: {
                    EditProfileView(entryStore: entryStore, longTermGoalStore: longTermGoalStore, dailyGoalStore: dailyGoalStore, weeklyGoalStore: weeklyGoalStore, profileStore: profileStore)
                })
                .applyShadow()
            }
            
            //Profile image / Image picker
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
            
            VStack {
                    HStack {
                        Text(nameText == "" ? "Add Your Name" : nameText)
                            .font(.system(size: 40, weight: .semibold, design: .default))
                            .foregroundColor(Color("ModeColor"))
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
                
                //Bottom section
                Reminder(
                    targetTime: $targetTime,
                    journalTime: $journalTime,
                    profileStore: profileStore,
                    isTargetsExpanded: false,
                    isJournalExpanded: false,

                    onTapSaveTargetTime: onTapSaveTargetTime,
                    onTapSaveJournalTime: onTapSaveJournalTime
                )
                .padding(.horizontal)
                
                Spacer()
                    
                .ignoresSafeArea()
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .navigationBarTitle("Pick a photo")
            
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .pink]), startPoint: .topLeading, endPoint: .trailing).ignoresSafeArea())
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = inputImage
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
            .padding(.vertical, 10)
            .foregroundColor(Color("ModeColor"))
            .multilineTextAlignment(.center)
    }
}

struct MiddleTitlesModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .multilineTextAlignment(.center)
            .font(.system(size: 24, weight: .semibold, design: .default))
    }
}

struct BottomTitlesModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .multilineTextAlignment(.center)
            .font(.system(size: 16, weight: .regular, design: .default))
            .foregroundColor(Color("ModeColor")).opacity(0.4)
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
