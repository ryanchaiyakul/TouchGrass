//
//  GrassScore.swift
//  SimpleApp
//
//  Created by Sanjana Kale on 1/21/23.
//

import Foundation
import SwiftUI

class GrassScore : ObservableObject {
    @Published var UVData = [Int]()
    @Published var tempData = [Double]()
    @Published var humidityData = [Int]()
    @Published var soilData = [Double]()

    @Published var totalScore : Int = 30
    @Published var touchedGrassCount : Int = 2

    var timer : Timer? = nil

    init() {
//        updateValues()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            if let strongSelf = self {
//                strongSelf.updateValues()
//                strongSelf.updateValues()
            }
        }
    }

    deinit {
        timer?.invalidate()
    }

    func updateTotal() {
        // something to calculate scores based off of list?? of uv values
    }

    func updateGrassScore() {
        // something that will measure the duration of the soil moisture at a certain level
    }

    func updateValues() {
        Task {
            // call to remote url e.g. firebase to populate data
            var json : [String : Any] = [:]
            do {

                // if needs a url
                let url = URL(string : "")
                let data = try await URLSession.shared.data(from: url!).0

                // if just needs a file; read in from here
                json = try JSONSerialization.jsonObject(with: data) as! [String : Any]


                // data object 1 : uvdata
                if let arr = json["_x_"] as? [[String : Any]] {
                    if let val = arr.first?["_x_"] as? Int {
                        Task { @MainActor in
                            self.UVData.append(val)
                        }
                    }
                }

                // data object 2 : tempvalue
                if let arr = json["_x_"] as? [String : Any] {
                    if let val = arr["_x_"] as? Double {
                        Task { @MainActor in
                            self.tempData.append(val)
                        }
                    }
                }

                // data object 3 : humidity
                if let arr = json["_x_"] as? [String : Any] {
                    if let hum = arr["_x_"] as? Int {
                        Task { @MainActor in
                            self.humidityData.append(hum)
                        }
                    }
                }

                // data object 4 : soilMoisture
                if let arr = json["_x_"] as? [String : Any] {
                    if let soil = arr["_x_"] as? Double {
                        Task { @MainActor in
                            self.soilData.append(soil)
                            if (soilData.count > 3600) {
                                
                            }
                        }
                    }
                }
                updateTotal()
                updateGrassScore()
            } catch {
                print(error)
            }
        }
    }


}

struct GrassDisplayView : View {
    let w : Double = 140
    let h : Double = 350
    let r : Double = 12
    let barH : Double = 300
    let score : GrassScore
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .frame(width: self.w, height: self.h)
                .cornerRadius(r)
            Rectangle()
                .fill(.white)
                .frame(width: self.w * 0.94, height: self.h * 0.98)
                .cornerRadius(0.8 * r)
            Rectangle()
                .fill(.green)
                .frame(width: w * 0.85, height: barH)
                .cornerRadius(0.65*r)
                .position(x: 215, y: 396 + (328 - barH)/2.0)
//            Rectangle()
//                .fill(.brown)
//                .frame(width: w * 0.85, height: barH)
//                .cornerRadius(0.65*r)
//                .position(x: 215, y: 396 + (328 - barH)/2.0)
        }
    }
    
    
}
