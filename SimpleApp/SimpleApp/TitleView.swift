//
//  TitleView.swift
//  SimpleApp
//
//  Created by Sanjana Kale on 1/21/23.
//

import Foundation
import SwiftUI

struct TitleView: View {
    @State var buttonPressed = false
    
    var body: some View {
        ZStack {
            Image("")
            Button("Begin") {
                // TODO: make this switch either to stats or device config. view depending on connection
                buttonPressed = true
            }
        }
        .background(.white)
        .cornerRadius(20)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}


