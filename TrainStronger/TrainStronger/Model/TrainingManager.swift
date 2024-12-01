//
//  TrainingManager.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 12. 01..
//

import Foundation
import SwiftData

class TrainingManarger{
    var modelContainer : ModelContainer?
    
    static let shared : TrainingManarger = {
        let instance = TrainingManarger()
        return instance
    }()
    
    private init(){}
    
    @MainActor
    func storeTraining(training: Training){
        modelContainer?.mainContext.insert(training)
    }
    
    @MainActor
    func deleteTraining(training: Training){
        modelContainer?.mainContext.delete(training)
    }
}
