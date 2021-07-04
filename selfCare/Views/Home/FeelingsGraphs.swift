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
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("ModeColor"))
                .opacity(0.2)
            
            VStack(alignment: .leading) {
                Text("Your ratings this week:")
                    .font(.system(size: 20, weight: .bold, design: .default))
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
                    .padding()
                    .accentColor(.white)
                    .foregroundColor(.white)
            }
        }
        
    }
}
