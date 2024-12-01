//
//  Training.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 30..
//

import Foundation
import SwiftData

@Model
class Training : Identifiable{
    var name : String
    var exercises: [Exercise]
    var date : Date
    var latitude : Double
    var longitude : Double
    
    init(date : Date){
        self.date = date
        self.exercises = []
        self.name = ""
        self.latitude = 0.0
        self.longitude = 0.0
    }
}
