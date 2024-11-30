//
//  Exercise.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 29..
//

import Foundation

@Observable
class Exercise : Identifiable{
    var name : String
    var sets : [Set]

    
    init(name : String){
        self.name = name
        self.sets = []
    }
    
    init(name : String, sets : [Set]){
        self.name = name
        self.sets = sets
    }
    
    func addNewSet(set: Set){
        sets.append(set)
    }
}
