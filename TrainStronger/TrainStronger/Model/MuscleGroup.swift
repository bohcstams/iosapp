//
//  MuscleGroup.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 30..
//

import Foundation
import SwiftData

@Model
class MuscleGroup : Identifiable{
    var name : String
    var exerciseTypes : [ExerciseType]
    
    init(name : String, types: [String]){
        self.name = name
        self.exerciseTypes = types.map { ExerciseType(type: $0) }
        self.exerciseTypes.sort { $0.type < $1.type }
    }
}

class MuscleGroupDTO : Identifiable, Codable{
    var name : String
    var exerciseTypes : [String]
    
    init(name : String, types: [String]){
        self.name = name
        self.exerciseTypes = types
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case exerciseTypes
    }
}
