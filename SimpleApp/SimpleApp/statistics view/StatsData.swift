//
//  StatsData.swift
//  SimpleApp
//
//  Created by Sanjana Kale on 1/21/23.
//

import Foundation
import SwiftUI

class Statistic: ObservableObject, Hashable, Equatable {
    static func == (lhs: Statistic, rhs: Statistic) -> Bool {
        lhs.name == rhs.name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    let name: String
    @Published var value : Int
    
    
    init(name : String) {
        self.name = name
        self.value = 0;
    }
    
    func setValue(m : Int) {
        value = m
    }
    
}





