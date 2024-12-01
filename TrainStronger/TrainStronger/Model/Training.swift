//
//  Training.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 30..
//

import Foundation

@Observable
class Training : Identifiable{
    var name : String
    var exercises: [Exercise]
    var date : Date
    var latitude : Double
    var longitude : Double
    //TODO: Place positional coordinates to display these on map
    
    init(date : Date){
        self.date = date
        self.exercises = []
        self.name = ""
        self.latitude = 0.0
        self.longitude = 0.0
    }
    
//    init(date: Date, exercises: [Exercise]){
//        self.date = date
//        self.exercises = exercises
//        self.name = ""
//        self.latitude = 0.0
//        self.longitude = 0.0
//    }
}
