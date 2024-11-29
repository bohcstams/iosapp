//
//  Set.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 29..
//

import Foundation
import SwiftData

@Model
final class Set{
    var weight : Double
    var repetitions : Int
    
    init(weight : Double, reps: Int){
        self.weight = weight
        self.repetitions = reps
    }
}
