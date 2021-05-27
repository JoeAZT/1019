//
//  FeelingsGraphs.swift
//  selfCare
//
//  Created by Joseph Taylor on 26/05/2021.
//

import SwiftUI
import SwiftUICharts

let chartLegend = Legend(color: .white, label: "Your week")

let points: [DataPoint] = [

    .init(value: 3, label: "Mon", legend: chartLegend),
    .init(value: 2, label: "Tue", legend: chartLegend),
    .init(value: 7, label: "Wed", legend: chartLegend),
    .init(value: 10, label: "Thu", legend: chartLegend),
    .init(value: 8, label: "Fri", legend: chartLegend),
    .init(value: 6, label: "Sat", legend: chartLegend),
    .init(value: 7, label: "Sun", legend: chartLegend),
    
]

struct FeelingsGraphs: View {
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
                    
                    BarChartView(dataPoints: points)
                        .chartStyle(
                            BarChartStyle(
                                barMinHeight: 1,
                                showAxis: true,
                                axisLeadingPadding: 10,
                                showLabels: true,
                                labelCount: 10,
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
                        .padding()
        
                    //Use this webiste to create array that shows the last 7 days of emojis or graph entries
                    //https://reactgo.com/swift-get-last-n-elements-array/
                    
                }
            }
        }
    }
}

struct FeelingsGraphs_Previews: PreviewProvider {
    static var previews: some View {
        FeelingsGraphs()
    }
}
