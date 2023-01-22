//
//  ItemRow.swift
//  ItemRow
//
//  Created by ukale on 8/16/21.
//

import SwiftUI

struct ItemRow: View {
    let item: MenuItem
    let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]
    
    var body: some View {
        HStack {
            Image(item.thumbnailImage)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text("$\(item.price)")
                
                HStack {
                    // Use of \.self here because our array does not conform to Identifiable (elemenst have no id property), so we need to specify that the string itself is the identifier.
                    ForEach(item.restrictions, id: \.self) { restriction in
                        Text(restriction)
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(5)
                            .background(colors[restriction, default: .black])
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: MenuItem.example)
    }
}
