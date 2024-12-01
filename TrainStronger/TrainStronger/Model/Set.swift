//
//  Set.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 29..
//

import Foundation
import SwiftData

@Model
class Set: Identifiable{
    var weight : Double
    var repetitions : Int
    
    init(weight : Double, reps: Int){
        self.weight = weight
        self.repetitions = reps
    }
}
