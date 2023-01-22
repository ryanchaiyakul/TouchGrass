@_private(sourceFile: "OrderView.swift") import SimpleApp
import SwiftUI
import SwiftUI

extension OrderView_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/sanjanakale/Downloads/SimpleApp/SimpleApp/OrderView.swift", line: 42)
        OrderView().environmentObject(Order())
    
#sourceLocation()
    }
}

extension OrderView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/sanjanakale/Downloads/SimpleApp/SimpleApp/OrderView.swift", line: 14)
        NavigationView {
            List {
                Section {
                    ForEach(order.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }
                }
                Section {
                    NavigationLink(destination: CheckoutView()) {
                        Text(__designTimeString("#4759.[1].[1].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value", fallback: "Place Order"))
                    }
                }
            }
            .navigationTitle(__designTimeString("#4759.[1].[1].property.[0].[0].arg[0].value.[0].modifier[0].arg[0].value", fallback: "ORDER"))
            .listStyle(.insetGrouped)
            .background(.blue)
        }
        .background(.white)
        .cornerRadius(__designTimeInteger("#4759.[1].[1].property.[0].[0].modifier[1].arg[0].value", fallback: 20))
    
#sourceLocation()
    }
}

import struct SimpleApp.OrderView
import struct SimpleApp.OrderView_Previews
