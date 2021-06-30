//
//  NewEnrtyView.swift
//  selfCare
//
//  Created by Joseph Taylor on 02/05/2021.
//

import SwiftUI

struct NewEntryView: View {
    
    @State var ratingSlider: Double = 0.0
    @State var reflectionText: String = ""
    @State var happyText: String = ""
    @State var achievementText = ""
    @State var moodText: String = "😐"
    @State var mood: Entry.Mood = .ok
    @State var exercise = false
    @State var water = false
    @State var sleep = false
    @State var meditation = false
    @State var reading = false
    @State var fruit = false
    @State var productivity = false
    @Binding var showNewEntryView: Bool
    @ObservedObject var entryStore: EntryStore
    
    var body: some View {
        
        VStack {
            
            //Screen Title
            Text("New Entry")
                .fontWeight(.semibold)
                .foregroundColor(Color("TextColor"))
                .font(.title)
                
            
            ScrollView {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 380, height: 130, alignment: .center)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                        
                    
                    VStack {
                        //First line
                        HStack {
                            Text("How was your day?")
                                .fontWeight(.bold)
                                .foregroundColor(Color("TextColor"))
                            Spacer()
                            
                            Text(String(format: "%.1f", ratingSlider))
                                .fontWeight(.bold)
                                .foregroundColor(Color("TextColor"))
                        }
                        
                        //Slider
                        HStack {
                            Text("0")
                                .foregroundColor(Color("TextColor"))
                            ZStack {
                                
                                LinearGradient(
                                    gradient: Gradient(colors: [.pink, .blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .mask(Slider(value: $ratingSlider, in: 0.0...10.0))
                                
                                Slider(value: $ratingSlider, in: 0.0...10.0)
                                    .opacity(0.05)
                            }
                            Text("10")
                                .foregroundColor(Color("TextColor"))
                        }
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 380, height: 380, alignment: .center)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                    
                    VStack {
                        //Reflection
                        Text(String(format: "Why was your day %.1f/10?", ratingSlider))
                            .fontWeight(.bold)
                            .foregroundColor(Color("TextColor"))
//                            .frame(width: 370, height: 20, alignment: .leading)
                            
                        ZStack(alignment: .top) {
                            TextViewWrapper(text: $reflectionText)
                                .frame(width: 340, height: 290, alignment: .leading)
                                .cornerRadius(10)
                            
                            if reflectionText.isEmpty {
                                Text("Today I felt...")
                                    .opacity(0.3)
                                    .padding(.trailing, 220)
                                    .padding(.top, 10)
                                    .padding()
                            }
                        }
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 380, height: 380, alignment: .center)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                    
                    VStack {
                        Text("What made you happy today?")
                            .fontWeight(.bold)
                            .foregroundColor(Color("TextColor"))
//                            .frame(width: 370, height: 20, alignment: .leading)
                        
                        ZStack {
                            TextViewWrapper(text: $happyText)
                                .frame(width: 340, height: 290, alignment: .center)
                                .cornerRadius(10)
                            
                            if happyText.isEmpty {
                                Text("I was happy today because...")
                                    .opacity(0.3)
                                    .padding(.trailing, 95)
                                    .padding(.bottom, 235)
                                    .padding()
                            }
                        }
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 380, height: 380, alignment: .center)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                    
                    VStack {
                        Text("What did you achieve today?")
                            .fontWeight(.bold)
                            .foregroundColor(Color("TextColor"))
//                            .frame(width: 370, height: 20, alignment: .leading)
                        
                        ZStack {
                            TextViewWrapper(text: $achievementText)
                                .frame(width: 340, height: 290, alignment: .center)
                                .cornerRadius(10)
                            
                            if happyText.isEmpty {
                                Text("Today, I...")
                                    .opacity(0.3)
                                
                            }
                        }
                    }
                }
            
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 380, height: 170, alignment: .center)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                    
                    VStack {
                        Text("Use an emoji to describe how you felt about today:")
                            .fontWeight(.bold)
                            .lineLimit(nil)
                            .foregroundColor(Color("TextColor"))
//                            .frame(width: 340, height: 50, alignment: .center)
                        
                        HStack {
                            Button(action: {
                                mood = .vsad
                                
                            }, label: {
                                Text("😣")
                                    .font(.system(size: 50, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(2)
                                    .cornerRadius(15)
                                    .opacity(mood == .vsad ? 1 : 0.5)
                                
                            })
                            
                            Button(action: {
                                mood = .sad
                                
                            }, label: {
                                Text("😞")
                                    .font(.system(size: 50, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(2)
                                    .cornerRadius(15)
                                    .opacity(mood == .sad ? 1 : 0.5)
                                
                            })
                            
                            Button(action: {
                                mood = .ok
                                
                            }, label: {
                                Text("😐")
                                    .font(.system(size: 50, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(2)
                                    .cornerRadius(15)
                                    .opacity(mood == .ok ? 1 : 0.5)
                            })
                            
                            Button(action: {
                                
                                mood = .good
                                
                            }, label: {
                                Text("😊")
                                    .font(.system(size: 50, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(2)
                                    .cornerRadius(15)
                                    .opacity(mood == .good ? 1 : 0.5)
                            })
                            
                            Button(action: {
                                mood = .vgood
                                
                            }, label: {
                                Text("😄")
                                    .font(.system(size: 50, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(2)
                                    .cornerRadius(15)
                                    .opacity(mood == .vgood ? 1 : 0.5)
                            })
                        }
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 380, height: 170, alignment: .center)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                    
                    VStack {
                        Text("Your daily wellbeing checklist:")
                            .fontWeight(.bold)
                            .lineLimit(nil)
                            .foregroundColor(Color("TextColor"))
//                            .frame(width: 340, height: 50, alignment: .center)
                            .padding()
                        
                        HStack {
                            //exercise
                            Button(action: {
                                if exercise == true {
                                    exercise = false
                                } else {
                                    exercise = true
                                }
                            }, label: {
                                Text("🏋️ Exercise")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color("TextColor"))
                                    .padding(2)
                                    .cornerRadius(15)
                                    .opacity(exercise == true ? 1 : 0.5)
                            })
                            
                            //exercise
                            Button(action: {
                                if water == true {
                                    water = false
                                } else {
                                    water = true
                                }
                            }, label: {
                                Text("🚰 Water Intake")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color("TextColor"))
                                    .padding(2)
                                    .cornerRadius(15)
                                    .opacity(water == true ? 1 : 0.5)
                            })
                        }
                            
                        HStack {
                            Button(action: {
                                if sleep == true {
                                    sleep = false
                                } else {
                                    sleep = true
                                }
                            }, label: {
                                Text("💤 8 hours of sleep")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color("TextColor"))
                                    .padding(2)
                                    .cornerRadius(15)
                                    .opacity(sleep == true ? 1 : 0.5)
                            })
                            
                            
                            Button(action: {
                                if fruit == true {
                                    fruit = false
                                } else {
                                    fruit = true
                                }
                            }, label: {
                                Text("🍎 5 Fruit & Veg")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color("TextColor"))
                                    .padding(2)
                                    .cornerRadius(15)
                                    .opacity(fruit == true ? 1 : 0.5)
                            })
                        }
                        
                        HStack {
                            Button(action: {
                                if reading == true {
                                    reading = false
                                } else {
                                    reading = true
                                }
                            }, label: {
                                Text("📚 Reading")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color("TextColor"))
                                    .padding(2)
                                    .cornerRadius(15)
                                    .opacity(reading == true ? 1 : 0.5)
                            })
                            
                            Button(action: {
                                if productivity == true {
                                    productivity = false
                                } else {
                                    productivity = true
                                }
                            }, label: {
                                Text("📈 Productivity")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color("TextColor"))
                                    .padding(2)
                                    .cornerRadius(15)
                                    .opacity(productivity == true ? 1 : 0.5)
                            })
                        }
                            
                            HStack {
                            Button(action: {
                                if meditation == true {
                                    meditation = false
                                } else {
                                    meditation = true
                                }
                            }, label: {
                                Text("🧘 Meditation")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color("TextColor"))
                                    .padding(2)
                                    .cornerRadius(15)
                                    .opacity(meditation == true ? 1 : 0.5)
                            })
                            
                        }
                        .padding(.horizontal)
                    }
                }
            
                //complete entry button
                Button(action: {
                    
                    self.showNewEntryView = false
                    let entry = Entry(id: UUID().uuidString, rating: ratingSlider, reflectionText: reflectionText, happyText: happyText, achievementText: achievementText, mood: mood, date: Date(), exercise: exercise, water: water, sleep: sleep, meditation: meditation, fruit: fruit, reading: reading, productivity: productivity)
                    entryStore.addEntry(entry)
                    
                }, label: {
                    Text("Complete Entry")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color .blue, .pink]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(15)
                })
                .padding()
            }
        }
    }
}

struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

