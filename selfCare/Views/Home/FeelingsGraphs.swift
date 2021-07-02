//
//  FeelingsGraphs.swift
//  selfCare
//
//  Created by Joseph Taylor on 26/05/2021.
//

import SwiftUI
import SwiftUICharts

let chartLegend = Legend(color: .white, label: "")

struct FeelingsGraphs: View {
    
    @ObservedObject var entryStore: EntryStore
    
    var body: some View {
        
        ScrollView {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 400, height: 470, alignment: .center)
                    .opacity(0.2)
                
                VStack(alignment: .leading) {
                    Text("Your ratings this week:")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .padding()
                    
                    LineChartView(dataPoints: entryStore.graphEntries)
                        .chartStyle(
                            LineChartStyle(
                                lineMinHeight: 1,
                                showAxis: true,
                                axisLeadingPadding: 10,
                                showLabels: true,
                                labelCount: 7,
                                showLegends: false
                            )
                        )
                        .frame(width: 350, height: 350, alignment: .center)
                        .padding()
                        .accentColor(.white)
                        .foregroundColor(.white)
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 400, height: 120, alignment: .center)
                    .opacity(0.2)
                
                VStack(alignment: .leading) {
                    Text("Your mood this week:")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .padding(.leading, 25)
        
                    //Use this webiste to create array that shows the last 7 days of emojis or graph entries
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(entryStore.entries.map(\.value)) { entry in
                                Text(entry.mood.rawValue)
                                    .font(.system(size: 40, weight: .regular, design: .default))
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
}

//struct FeelingsGraphs_Previews: PreviewProvider {
//    static var previews: some View {
//        FeelingsGraphs()
//    }
//}
