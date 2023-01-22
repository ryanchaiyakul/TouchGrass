@_private(sourceFile: "StatsRow.swift") import SimpleApp
import Foundation
import SwiftUI
import SwiftUI

extension StatsRow_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/sanjanakale/Downloads/SimpleApp/SimpleApp/statistics view/StatsRow.swift", line: 49)
        StatsRow(data: Statistic(name: __designTimeString("#5290.[3].[0].property.[0].[0].arg[0].value.arg[0].value", fallback: "my data value")))
    
#sourceLocation()
    }
}

extension StatsRow {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/sanjanakale/Downloads/SimpleApp/SimpleApp/statistics view/StatsRow.swift", line: 15)
        HStack {
            Text(data.name)
                .padding(__designTimeInteger("#5290.[2].[1].property.[0].[0].arg[0].value.[0].modifier[0].arg[0].value", fallback: 20))
            Text(String(data.value))
            
            
            
//            Image(item.thumbnailImage)
//                .clipShape(Circle())
//            VStack(alignment: .leading) {
//                Text(item.name)
//                    .font(.headline)
//                Text("$\(item.price)")
//
//                HStack {
//                    // Use of \.self here because our array does not conform to Identifiable (elemenst have no id property), so we need to specify that the string itself is the identifier.
//                    ForEach(item.restrictions, id: \.self) { restriction in
//                        Text(restriction)
//                            .font(.caption)
//                            .fontWeight(.black)
//                            .padding(5)
//                            .clipShape(Circle())
//                            .foregroundColor(.white)
//                    }
//                }
//            }
//
//            Spacer()
        }
    
#sourceLocation()
    }
}

import struct SimpleApp.StatsRow
import struct SimpleApp.StatsRow_Previews
