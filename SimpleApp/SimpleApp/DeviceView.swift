//
//  DeviceView.swift
//  SimpleApp
//
//  Created by Sanjana Kale on 1/21/23.
//
import Foundation
import SwiftUI

struct DeviceView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    @EnvironmentObject var order: Order
    
    var body: some View {
        
        VStack {
            
            Text("Device Configuration");
            
            Button("Pair Device") {
                // TODO: device pairing
            }
            
            HStack {
                Text("Current Device:")
                Text("_device_name_")
            }
//                .scaledToFit()
//                .frame(width: 200, height: 200)
            
            .padding(40)
            
            HStack {
                Image("bluetooth")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
                
                Text("enable bluetooth if not already enabled")
                    .multilineTextAlignment(.center)
                    .padding(0)
//                    .scaledToFit()
//                    .frame(width: 150, height: 150)
            }
            
        }
        .padding(40)
        
        
        .background(.white)
        .cornerRadius(20)
    }
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView()
    }
}



