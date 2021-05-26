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
        
        VStack {
            Text("Mood graph")
                .font(.system(size: 25, weight: .bold, design: .default))
                .foregroundColor(.white)
                .padding(.trailing, 200)
                
            
            LineChartView(dataPoints: points)
                .frame(width: 400, height: 500, alignment: .center)
                .padding()
                .accentColor(.white)
        }
    }
}

struct FeelingsGraphs_Previews: PreviewProvider {
    static var previews: some View {
        FeelingsGraphs()
    }
}
