//
//  ContentView.swift
//  SimpleApp
//
//  Created by ukale on 1/20/23.
//

import SwiftUI

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationView {
            List {
                Text("Items: \($order.items.count)")
                ForEach(menu) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items) { item in
                            NavigationLink(destination: ItemDetail(item: item)) {
                                ItemRow(item: item)
                            }
                        }
                    }
                }
            }
            .navigationTitle("MENU")
            .listStyle(.grouped)
            .background(.orange)
        }
        .background(.white)
        .cornerRadius(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
