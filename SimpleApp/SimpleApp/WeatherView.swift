//
//  WeatherView.swift
//  SimpleApp
//
//  Created by Sanjana Kale on 1/21/23.
//

import Foundation
import SwiftUI


class WeatherData: ObservableObject {
    @Published var dateStr = ""
    @Published var currentCond = ""
    @Published var temp : Double = 0
    
    // get gps values from device and change this!!!
    let lat : Double = 34.07398
    let lon : Double = -118.4523957
    
    var timer : Timer? = nil
    
    
    
    init() {
        foo()
        dateStr = getCurrentTime()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            if let strongSelf = self {
                strongSelf.dateStr = strongSelf.getCurrentTime()
                strongSelf.foo()
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func getCurrentTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
        let hour = components.hour
        let minutes = components.minute
        let seconds = components.second
        
        return "\(Int(hour!)):\(Int(minutes!)):\(Int(seconds!))"
    }
    
//    func foo() {
//        DispatchQueue.global().async {
//            // call to remote url e.g. firebase to populate data
//            let url = URL(string : "https://api.openweathermap.org/data/2.5/weather?lat=34.07398&lon=-118.4523957&appid=8e727bed604e2747e116bd7dabc04b7c")
//            let data = URLSession.shared.data(from: url!)
//
//            DispatchQueue.main.async {
//                // use data to update the local variables in the class
//
//            }
//        }
//
        
//    }
    
    func foo() {
        Task {
            // call to remote url e.g. firebase to populate data
            var json : [String : Any] = [:]
            do {
                // get lat and long values for the current device
                
                let url = URL(string : "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=8e727bed604e2747e116bd7dabc04b7c")
                let data = try await URLSession.shared.data(from: url!).0
                json = try JSONSerialization.jsonObject(with: data) as! [String : Any]
                
                
                if let arr = json["weather"] as? [[String : Any]] {
                    if let desc = arr.first?["description"] as? String {
                        Task { @MainActor in
                            self.currentCond = desc
                        }
                    }
                }
                
                if let arr = json["main"] as? [String : Any] {
                    if let temp = arr["temp"] as? Double {
                        Task { @MainActor in
                            self.temp = temp
                        }
                    }
                }
                
            } catch {
                print(error)
            }
        }
        
    }
    
}



struct WeatherView: View {
    @ObservedObject var weatherData : WeatherData
    
    var body: some View {
        VStack(spacing: 10) {
            Text(weatherData.currentCond)
            Text(weatherData.dateStr)
            Text("\(Int((weatherData.temp - 273)*(9.0/5) + 32))˚F")
            
        }
        
        
    }
}




//struct WeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherView()
//    }
//}
