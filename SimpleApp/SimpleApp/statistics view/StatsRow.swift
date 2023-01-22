//
//  StatsRow.swift
//  SimpleApp
//
//  Created by Sanjana Kale on 1/21/23.
//

import Foundation
import SwiftUI

struct StatsRow: View {
    let data : Statistic
    
    var body: some View {
        HStack(spacing: 20) {
            Text(data.name)
                .foregroundColor(.white)
                .padding(20)
                .frame(width: 250)
                .background(Color(.systemGray))
                .cornerRadius(20)
                
                
            Spacer()
            Text(String(data.value))
                .foregroundColor(.white)
                .padding(20)
                .frame(width: 100)
                .background(Color(.systemGray2))
                .cornerRadius(20)
            
            
            
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
    }
}

struct StatsRow_Previews: PreviewProvider {
    static var previews: some View {
        StatsRow(data: Statistic(name: "my data value"))
    }
}
