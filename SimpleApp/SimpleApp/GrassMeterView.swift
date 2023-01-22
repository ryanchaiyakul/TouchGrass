//
//  GrassMeterView.swift
//  SimpleApp
//
//  Created by Sanjana Kale on 1/21/23.
//

import Foundation

import SwiftUI


struct GrassMeterView: View {
    let quips : [String] = ["Grass levels are looking quite low", "Hmm, better go touch some grass", "Looking Grassy.", "Grassiness is at an all time high."]
    @StateObject var grassScore : GrassScore
    
    var body: some View {
        ZStack {
            Text("GrassMeter")
                .fontWeight(.semibold)
                .font(.system(size: 30))
//                    .padding(30)
                .position(x: 215, y: 100)
            GrassDisplayView(score: grassScore)
            //            Spacer()
                .position(x: 215, y: 400)
            

            
                var text = grassScore.totalScore < 10 ? quips[0] : (grassScore.totalScore < 40 ? quips[1] : (grassScore.totalScore < 70 ? quips[2] : quips[3]))
                Text(text)
                .frame(width: 250, height: 70)
//                .background(Color(red: 222 / 255, green: 222 / 255, blue: 222 / 255))
//                .cornerRadius(10)
                .padding(100)
                .multilineTextAlignment(.center)
                .position(x : 215, y : 650)
                
        }
        
    }
}

struct GrassMeterView_Previews: PreviewProvider {
    static var previews: some View {
        GrassMeterView(grassScore: .init())
    }
}
