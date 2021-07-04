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
    @State var outside = false
    @Binding var showNewEntryView: Bool
    @ObservedObject var entryStore: EntryStore
    
    var body: some View {
    
        VStack {
            
            //Screen Title
            Text("New Entry")
                .fontWeight(.semibold)
                .foregroundColor(Color("TextColor"))
                .font(.title)
                .padding()
                
            
            ScrollView {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
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
                        .padding(.top, 5)
                        .padding()
                        
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
                        .padding()
                    }
                    .padding(.horizontal, 20)
                }
                .padding(10)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                    
                    
                    //Reflection
                    VStack(alignment: .leading) {
                        Text(String(format: "Why was your day %.1f/10?", ratingSlider))
                            .fontWeight(.bold)
                            .foregroundColor(Color("TextColor"))
                            
                        ZStack(alignment: .topLeading) {
                            TextViewWrapper(text: $reflectionText)
                                .frame(width: 340, height: 290, alignment: .leading)
                                .cornerRadius(10)
                            
                            if reflectionText.isEmpty {
                                Text("Today I felt...")
                                    .opacity(0.3)
                                    .padding()
                            }
                        }
                    }
                    .padding()
                }
                .padding(10)
                
                //Happy
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                    
                    VStack(alignment: .leading) {
                        Text("Something that made you happy today?")
                            .fontWeight(.bold)
                            .lineLimit(nil)
                            .foregroundColor(Color("TextColor"))
                        
                        ZStack(alignment: .topLeading) {
                            TextViewWrapper(text: $happyText)
                                .frame(width: 340, height: 290, alignment: .center)
                                .cornerRadius(10)
                            
                            if happyText.isEmpty {
                                Text("I was happy today because...")
                                    .opacity(0.3)
                                    .padding()
                            }
                        }
                    }
                    .padding()
                }
                .padding(10)
                
                
                //Achieve
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                    
                    VStack(alignment: .leading) {
                        Text("What did you achieve today?")
                            .fontWeight(.bold)
                            .lineLimit(nil)
                            .foregroundColor(Color("TextColor"))
                        
                        
                        ZStack(alignment: .topLeading) {
                            TextViewWrapper(text: $achievementText)
                                .frame(width: 340, height: 290, alignment: .center)
                                .cornerRadius(10)
                            
                            if achievementText.isEmpty {
                                Text("Today, I...")
                                    .opacity(0.3)
                                    .padding()
                                
                            }
                        }
                    }
                    .padding()
                }
                .padding(10)
            
                
                //Emoji
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                    
                    VStack {
                        Text("Use an emoji to describe your mood:")
                            .fontWeight(.bold)
                            .lineLimit(nil)
                            .foregroundColor(Color("TextColor"))
                        
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
                    .padding()
                }
                .padding(10)
                
                
                //Well-being
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("ModeColor"))
                        .applyShadow()
                    
                    VStack {
                        Text("Your daily well-being checklist:")
                            .fontWeight(.bold)
                            .lineLimit(nil)
                            .foregroundColor(Color("TextColor"))
                            .padding(.top, 20)
                        
                        HStack {
                            VStack {
                                //exercise
                                Button(action: {
                                    if exercise == true {
                                        exercise = false
                                    } else {
                                        exercise = true
                                    }
                                }, label: {
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(exercise == true ? Color("ModeColor") : Color.gray.opacity(0.1))
                                                    .padding(.horizontal, 10)
                                            .applyShadow()
                                    Text("🏋️ Exercise")
                                        .font(.system(size: 19, weight: .bold))
                                        .foregroundColor(Color("TextColor"))
                                        .padding(5)
                                        .opacity(exercise == true ? 1 : 0.5)
                                    }
                                })
                                
                                Button(action: {
                                    if sleep == true {
                                        sleep = false
                                    } else {
                                        sleep = true
                                    }
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(sleep == true ? Color("ModeColor") : Color.gray.opacity(0.1))
                                            .padding(.horizontal, 10)
                                            .applyShadow()
                                    Text("🛌 Quality Sleep")
                                        .font(.system(size: 19, weight: .bold))
                                        .foregroundColor(Color("TextColor"))
                                        .padding(5)
                                        .opacity(sleep == true ? 1 : 0.5)
                                    }
                                })
                                
                                Button(action: {
                                    if water == true {
                                        water = false
                                    } else {
                                        water = true
                                    }
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(water == true ? Color("ModeColor") : Color.gray.opacity(0.1))
                                            .padding(.horizontal, 10)
                                            .applyShadow()
                                    Text("🚰 Water intake")
                                        .font(.system(size: 19, weight: .bold))
                                        .foregroundColor(Color("TextColor"))
                                        .padding(5)
                                        .opacity(water == true ? 1 : 0.5)
                                    }
                                })
                                
                                Button(action: {
                                    if fruit == true {
                                        fruit = false
                                    } else {
                                        fruit = true
                                    }
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(fruit == true ? Color("ModeColor") : Color.gray.opacity(0.1))
                                            .padding(.horizontal, 10)
                                            .applyShadow()
                                    Text("🍎 5 Fruit & Veg")
                                        .font(.system(size: 19, weight: .bold))
                                        .foregroundColor(Color("TextColor"))
                                        .padding(5)
                                        .opacity(fruit == true ? 1 : 0.5)
                                    }
                                })
                            }
                            
                            VStack {
                                Button(action: {
                                    if reading == true {
                                        reading = false
                                    } else {
                                        reading = true
                                    }
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(reading == true ? Color("ModeColor") : Color.gray.opacity(0.1))
                                            .padding(.horizontal, 10)
                                            .applyShadow()
                                    Text("📚 Reading")
                                        .font(.system(size: 19, weight: .bold))
                                        .foregroundColor(Color("TextColor"))
                                        .padding(5)
                                        .opacity(reading == true ? 1 : 0.5)
                                    }
                                })
                                
                                Button(action: {
                                    if productivity == true {
                                        productivity = false
                                    } else {
                                        productivity = true
                                    }
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(productivity == true ? Color("ModeColor") : Color.gray.opacity(0.1))
                                            .padding(.horizontal, 10)
                                            .applyShadow()
                                    Text("📈 Productivity")
                                        .font(.system(size: 19, weight: .bold))
                                        .foregroundColor(Color("TextColor"))
                                        .padding(5)
                                        .opacity(productivity == true ? 1 : 0.5)
                                    }
                                })
                                
                                Button(action: {
                                    if meditation == true {
                                        meditation = false
                                    } else {
                                        meditation = true
                                    }
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(meditation == true ? Color("ModeColor") : Color.gray.opacity(0.1))
                                            .padding(.horizontal, 10)
                                            .applyShadow()
                                    Text("🧘 Medititaion")
                                        .font(.system(size: 19, weight: .bold))
                                        .foregroundColor(Color("TextColor"))
                                        .padding(5)
                                        .opacity(meditation == true ? 1 : 0.5)
                                    }
                                })
                                
                                Button(action: {
                                    if outside == true {
                                        outside = false
                                    } else {
                                        outside = true
                                    }
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(outside == true ? Color("ModeColor") : Color.gray.opacity(0.1))
                                            .padding(.horizontal, 10)
                                            .applyShadow()
                                    Text("☀️ Go Outside")
                                        .font(.system(size: 19, weight: .bold))
                                        .foregroundColor(Color("TextColor"))
                                        .padding(5)
                                        .opacity(outside == true ? 1 : 0.5)
                                    }
                                })
                            }
                        }
                        .padding()
                    }
                }
                .padding(10)
            
                //complete entry button
                Button(action: {
                    
                    self.showNewEntryView = false
                    let entry = Entry(id: UUID().uuidString, rating: ratingSlider, reflectionText: reflectionText, happyText: happyText, achievementText: achievementText, mood: mood, date: Date(), exercise: exercise, water: water, sleep: sleep, meditation: meditation, fruit: fruit, reading: reading, productivity: productivity, outside: outside)
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
