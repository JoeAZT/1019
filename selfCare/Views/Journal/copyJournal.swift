//
//  copyJournal.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/07/2021.
//

//import Foundation
//
//@ObservedObject var entryStore: EntryStore
//@State private var showNewEntryView = false
//@State var expandedEntry: String?
//
//var body: some View {
//
//    VStack {
//        Text("Journal")
//            .fontWeight(.semibold)
//            .foregroundColor(Color("TextColor"))
//            .font(.title)
//            .padding()
//
//        ZStack {
//            List {
//                ForEach(entryStore.entries.map(\.value)) { entry in
//
//                    VStack(alignment: .leading) {
//                    Text(entry.date, style: .date)
//                        .fontWeight(.bold)
//                    }
//
//
//
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 10)
//                                .foregroundColor(Color("ModeColor"))
//                                .applyShadow()
//                        }
//                }
//            }
//

//VStack(alignment: .center){
//    if self.expandedEntry != entry.id {
//
//        Image(systemName: "chevron.compact.down")
//    } else {
//        Text("How was your day?:")
//            .fontWeight(.semibold)
//            .padding(.top, 1)
//        Text(entry.reflectionText)
//            .lineLimit(10)
//            .padding(.bottom, 1)
//        if self.expandedEntry == entry.id {
//            Text("How was your day?:")
//                .fontWeight(.semibold)
//            Text(entry.happyText)
//                .lineLimit(nil)
//                .padding(.bottom, 1)
//            Text("How was your day?:")
//                .fontWeight(.semibold)
//            Text(entry.achievementText)
//                .lineLimit(nil)
//                .padding(.bottom, 1)
//            Image(systemName: "chevron.compact.up")
//                .padding()
//        }
//    }
//}
//.padding()
//}
//.onTapGesture {
//    if self.expandedEntry == entry.id {
//        self.expandedEntry = nil
//    } else {
//        self.expandedEntry = entry.id
//    }
//}
//.animation(.spring())
//                        .layoutPriority(1)
//
//                        HStack {
//                            VStack {
//                                //Rating
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .foregroundColor(Color("ModeColor"))
//                                        .applyShadow()
//                                    VStack {
//                                        Text("Rating:")
//                                            .fontWeight(.semibold)
//                                            .font(.system(size: 14))
//                                        Text(String(format: "%.1f", entry.rating))
//                                            .font(.system(size: 40, weight: .bold, design: .default))
//                                    }
//                                }
//                                .frame(width: 100)
//
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .foregroundColor(Color("ModeColor"))
//                                        .applyShadow()
//                                    VStack {
//                                        Text("Mood:")
//                                            .fontWeight(.semibold)
//                                            .font(.system(size: 15))
//                                        Text(entry.mood.rawValue)
//                                            .font(.system(size: 40))
//                                    }
//                                }
//                                .frame(width: 100)
//                            }
//
//                            VStack {
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .foregroundColor(Color("ModeColor"))
//                                        .applyShadow()
//                                    VStack(alignment: .leading, spacing: 10) {
//                                        Text("Well-being checklist:")
//                                            .font(.system(size: 15, weight: .semibold, design: .default))
//                                        HStack(spacing: 15) {
//                                            Text("🏋️")
//                                                .font(.system(size: 40, weight: .bold, design: .default))
//                                                .opacity(entry.exercise == true ? 1 : 0.2)
//                                            Text("🛌")
//                                                .font(.system(size: 40, weight: .bold, design: .default))
//                                                .opacity(entry.sleep == true ? 1 : 0.2)
//                                            Text("🚰")
//                                                .font(.system(size: 40, weight: .bold, design: .default))
//                                                .opacity(entry.water == true ? 1 : 0.2)
//                                            Text("🍎")
//                                                .font(.system(size: 40, weight: .bold, design: .default))
//                                                .opacity(entry.fruit == true ? 1 : 0.2)
//                                        }
//
//                                        //Mood
//                                        HStack(spacing: 15) {
//                                            Text("📚")
//                                                .font(.system(size: 40, weight: .bold, design: .default))
//                                                .opacity(entry.reading == true ? 1 : 0.2)
//                                            Text("📈")
//                                                .font(.system(size: 40, weight: .bold, design: .default))
//                                                .opacity(entry.productivity == true ? 1 : 0.2)
//                                            Text("🧘")
//                                                .font(.system(size: 40, weight: .bold, design: .default))
//                                                .opacity(entry.meditation == true ? 1 : 0.2)
//                                            Text("☀️")
//                                                .font(.system(size: 40, weight: .bold, design: .default))
//                                                .opacity(entry.outside == true ? 1 : 0.2)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//
//            if entryStore.entries.isEmpty {
//                VStack {
//                    Image(systemName: "plus.circle")
//                        .font(.system(size: 200, weight: .regular, design: .default))
//                        .padding(30)
//
//                    Text("When you create journal entries they will appear on this screen. It's ok if you dont want to write anything down some days, you just have to give me a rating.")
//                        .font(.system(size: 20, weight: .regular, design: .default))
//                        .multilineTextAlignment(.center)
//                        .padding(.horizontal, 60)
//                }
//                .opacity(0.4)
//                .padding(.bottom, 50)
//            }
//        }
//
//        Button(action: {
//            showNewEntryView.toggle()
//
//        }, label: {
//            Text("Create Entry")
//                .font(.system(size: 20, weight: .bold))
//                .foregroundColor(.white)
//                .padding()
//                .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .pink]), startPoint: .leading, endPoint: .trailing))
//                .cornerRadius(15)
//        })
//    }
//
//    .sheet(isPresented: $showNewEntryView) {
//        NewEntryView(showNewEntryView: $showNewEntryView, entryStore: entryStore)
//    }
//}

