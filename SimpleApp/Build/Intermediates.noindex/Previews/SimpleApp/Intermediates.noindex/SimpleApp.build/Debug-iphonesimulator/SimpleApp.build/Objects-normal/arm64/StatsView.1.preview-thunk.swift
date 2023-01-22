@_private(sourceFile: "StatsView.swift") import SimpleApp
import Foundation
import SwiftUI
import SwiftUI

extension StatsView_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/sanjanakale/Downloads/SimpleApp/SimpleApp/statistics view/StatsView.swift", line: 46)
        StatsView()
    
#sourceLocation()
    }
}

extension StatsView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/sanjanakale/Downloads/SimpleApp/SimpleApp/statistics view/StatsView.swift", line: 21)
            List {
                ForEach(data, id: \.self) { stat in
                    StatsRow(data: stat)
                }
                
//                ForEach(data) { section in
//                    Section(header: Text(section.name)) {
//                        ForEach(section.items) { item in
//                            StatsRow()
//
//                        }
//                    }
//                }
            }
            
            .listStyle(.grouped)
            .background(.white)
        
        .background(.white)
        .cornerRadius(__designTimeInteger("#4994.[2].[1].property.[0].[0].modifier[3].arg[0].value", fallback: 20))
    
#sourceLocation()
    }
}

import struct SimpleApp.StatsView
import struct SimpleApp.StatsView_Previews
