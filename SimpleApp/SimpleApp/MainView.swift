//
//  MainView.swift
//  MainView
//
//  Created by ukale on 8/16/21.
//

import SwiftUI

struct MainView: View {
//    @Binding var buttonPressed: Bool = 
    
    var body: some View {
        TabView {
            TitleView()
                .tabItem {
                    Label("Title", systemImage: "house")
                }
            DeviceView()
                .tabItem {
                    Label("Device", systemImage: "antenna.radiowaves.left.and.right")
                }
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "heart.circle")
                }
            WeatherView(weatherData: WeatherData())
                .tabItem {
                    Label("Weather", systemImage: "sun.max.fill")
                }

            GrassMeterView(grassScore: .init())
                .tabItem {
                    Label("Grass-meter", systemImage: "laurel.leading")
                }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(Order())
    }
}
