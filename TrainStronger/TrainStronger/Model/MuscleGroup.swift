//
//  MuscleGroup.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 30..
//

import Foundation

class MuscleGroup : Identifiable{
    var name : String
    var exerciseTypes : [String]
    
    init(name : String, types: [String]){
        self.name = name
        self.exerciseTypes = types
    }
}
