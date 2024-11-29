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
    var weight : Int
    var repetitions : Int
    
    init(weight : Int, reps: Int){
        self.weight = weight
        self.repetitions = reps
    }
}
