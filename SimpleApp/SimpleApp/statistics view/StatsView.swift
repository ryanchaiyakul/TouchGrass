//
//  StatsView.swift
//  SimpleApp
//
//  Created by Sanjana Kale on 1/21/23.
//

import Foundation
import SwiftUI

struct StatsView: View {
//    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
//    @EnvironmentObject var order: Order
    let data : [Statistic] = [
        .init(name: "Time spent outside"),
        .init(name: "Amount UV acquired"),
        .init(name: "Times grass was touched")
        
    ]
    
    var body: some View {
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
        .cornerRadius(20)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
